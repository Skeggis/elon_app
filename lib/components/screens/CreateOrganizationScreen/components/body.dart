import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CreateOrganizationScreen/components/CircularBorder.dart';
import 'package:myapp/services/helpers.dart' as helpers;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:myapp/services/models/Response.dart';
import 'package:myapp/services/ApiRequests.dart';
import 'package:myapp/components/screens/CreateOrganizationScreen/components/DeleteOrganizationDialog.dart';

import 'package:myapp/services/models/scopedModels/OrganizationModel.dart';
import 'package:myapp/services/models/Organization.dart';

//https://www.youtube.com/watch?v=lObDY_YENo8
//https://www.youtube.com/watch?v=HCmAwk2fnZc
//https://pub.dev/packages/image_picker/install

class CreateOrganizationBody extends StatefulWidget {
  bool isCreating;
  Organization organization;
  CreateOrganizationBody({this.isCreating = true, this.organization});
  @override
  State<StatefulWidget> createState() => _CreateOrganizationBody();
}

class _CreateOrganizationBody extends State<CreateOrganizationBody> {
  File _imageFile;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Future<void> _pickImage() async {
    final _picker = ImagePicker();
    _picker
        .getImage(source: ImageSource.gallery)
        .then((selected) => _cropImage(File(selected.path)));
  }

  Future<void> _cropImage(File imageToCrop) async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: imageToCrop.path,
        cropStyle: CropStyle.circle,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Widget _inputImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black45)]),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: helpers.screenWidth(context) * 0.45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _pickImage(),
              child: RepaintBoundary(
                child: _imageFile == null
                    ? CircularBorder(
                        width: 2,
                        size: helpers.screenWidth(context) * 0.45,
                        color: Colors.white.withOpacity(0.5),
                        icon: Icon(Icons.add, color: Colors.grey),
                      )
                    : Image.file(_imageFile),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputName(BuildContext context) {
    return TextField(
      controller: nameController,
      style: TextStyle(fontSize: 15),
      cursorColor: Colors.white.withOpacity(0.5),
      textAlign: TextAlign.left,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        prefixIcon:
            Icon(Icons.location_city, color: Colors.white.withOpacity(0.75)),
        hintText: "Name of Organization",
      ),
    );
  }

  Widget _inputs(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _inputImage(context),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.only(
              left: helpers.screenWidth(context) * 0.12,
              right: helpers.screenWidth(context) * 0.12),
          child: _inputName(context),
        )
      ],
    );
  }

  Widget _createOrganizationButton(BuildContext context) {
    return MaterialButton(
        onPressed: () async {
          print("HERE SONE!");
          //TODO: first send image to Firebase store!
          String imageUrl = "";

          if (nameController.text == '') {
            print("Shitter");
            helpers.showSnackBar(
                context, ["Please fill in the name for the organization"]);
            return false;
          }

          print("THERE");
          Response response;
          try {
            response = await OrganizationModel.of(context)
                .createOrganization(imageUrl, nameController.text);
          } catch (e) {
            print("ERROR: $e");
          }

          print("THERE");
          if (response.success) {
            Navigator.of(context).pop();
          } else if (response.errors != null && response.errors.length > 0) {
            return helpers.showSnackBar(context, response.errors);
          }
          print("THERE");
          return helpers.showSnackBar(
              context, ['Something went wrong. Please try again later.']);
        },
        child: Text(
          widget.isCreating ? "Create Organization" : "Edit Organization",
          style: TextStyle(fontSize: 18),
        ),
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.all(15),
        minWidth: helpers.screenWidth(context) * 0.7,
        shape: StadiumBorder(),
        colorBrightness: Brightness.dark,
        elevation: 25,
        highlightElevation: 12);
  }

  void _onDeleteOrganization() {}
  Future<void> _deleteOrganizationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => DeleteOrganizationDialog(
              organization: widget.organization,
              onDeleteOrganization: _onDeleteOrganization,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _inputs(context),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: _createOrganizationButton(context),
              ),
            ],
          ),
          widget.isCreating
              ? Container()
              : Positioned(
                  right: 5,
                  child: OutlineButton(
                    shape: CircleBorder(),
                    onPressed: () {},
                    color: Colors.red[400],
                    // borderSide: BorderSide(width: 1, color: Colors.red[400]),
                    child: Icon(
                      Icons.delete,
                      size: 35,
                      color: Colors.red[400],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
