
import 'dart:io';

import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../../controller/profile_provider.dart';
import '../../../controller/utils/firebase.dart';
import '../../../model/utils/const.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // final name = TextEditingController(text: "أحمد الحريري");
  bool nameIgnor = true;

  bool emailIgnor = true;

  //ProfileProvider profileProvider = ProfileProvider();
  ImagePicker picker = ImagePicker();

  XFile? image;
  pickFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {

    });
  }

  pickFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
   // await uploadImage( );
    setState(() {

    });
  }
  Future uploadImage() async {
    try {
      String path = basename(image!.path);
      print(image!.path);
      File file =File(image!.path);

//FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
      Reference storage = FirebaseStorage.instance.ref().child("profileImage/${path}");
      UploadTask storageUploadTask = storage.putFile(file);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      //Const.LOADIG(context);
      String url = await taskSnapshot.ref.getDownloadURL();
      //Navigator.of(context).pop();
      print('url $url');
      return url;
    } catch (ex) {
      //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ChangeNotifierProvider<ProfileProvider>(
        create: (_) => ProfileProvider(),
        child: Consumer<ProfileProvider>(
          builder: (context, value, child) => Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppPadding.p10, horizontal: AppPadding.p20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: Sizer.getW(context) * 0.35,
                        height: Sizer.getW(context) * 0.35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: AppSize.s4)),
                        child: image == null
                            ? ClipOval(
                            child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: Sizer.getW(context) * 0.14,
                          height: Sizer.getW(context) * 0.14,
                          imageUrl:
                          // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                          "${profileProvider.user.photoUrl}",
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              ProfilePicture(
                                name: profileProvider.user.name,
                                radius: AppSize.s30,
                                fontsize: Sizer.getW(context) / 22,
                              ),
                        ))
                            : ClipOval(
                                child: Image.file(File(image!.path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorManager.white,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Center(
                                      child: Container(
                                        height: Sizer.getW(context) * 0.4,
                                        width:
                                            Sizer.getW(context) - AppSize.s30,
                                        color: Theme.of(context).cardColor,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    pickFromCamera();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(
                                                        AppPadding.p8),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.camera),
                                                        const SizedBox(
                                                          width: AppSize.s8,
                                                        ),
                                                        Text("Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 0.0,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: ()  {

                                                    pickFromGallery();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(
                                                        AppPadding.p8),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.photo),
                                                        const SizedBox(
                                                          width: AppSize.s8,
                                                        ),
                                                        Text("Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Container(
                    child: Column(
                      children: [
                        StatefulBuilder(builder: (_, setState1) {
                          return CustomTextFiled(
                              onSubmit: (val) {
                                nameIgnor = true;
                                setState1(() {});
                              },
                              readOnly: nameIgnor,
                              controller: profileProvider.name,
                              validator: (String? val) {
                                if (val!.isEmpty) {
                                  return tr(LocaleKeys.field_required);
                                } else {
                                  return null;
                                }
                              },
                              onChange: (val) {},
                              prefixIcon: Icons.person,
                              maxLength: null,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  nameIgnor = false;
                                  //profileProvider.user.name="f";
                                  setState1(() {});
                                },
                                icon: Icon(Icons.edit),
                              ),
                              hintText: tr(LocaleKeys.name));
                        }),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        StatefulBuilder(builder: (_, setState2) {
                          return CustomTextFiled(
                              onSubmit: (val) {
                                emailIgnor = true;
                                setState2(() {});
                              },
                              readOnly: emailIgnor,
                              controller: profileProvider.email,
                              validator: (String? val) {
                                if (val!.isEmpty) {
                                  return tr(LocaleKeys.field_required);
                                } else if (!val.isEmail) {
                                  return tr(LocaleKeys.enter_valid_email);
                                } else {
                                  return null;
                                }
                              },
                              onChange: (val) {},
                              prefixIcon: Icons.email,
                              maxLength: null,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  emailIgnor = false;
                                  setState2(() {});
                                },
                                icon: Icon(Icons.edit),
                              ),
                              hintText: tr(LocaleKeys.email));
                        }),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        CustomTextFiled(
                            readOnly: true,
                            controller: TextEditingController(
                                text: profileProvider.user.phoneNumber /*"055 895 658"*/),
                            validator: (String? val) {},
                            onChange: (val) {},
                            prefixIcon: Icons.phone_android,
                            maxLength: null,
                            hintText: tr(LocaleKeys.phone_number)),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        StatefulBuilder(
                          builder: (_, setState2) {
                            return ButtonApp(
                                text: tr(LocaleKeys.edit),
                                onTap: () async {
                                  if(image!=null)
                                  await profileProvider.uploadImage(context, image!);
                                  Const.LOADIG(context);
                                  await profileProvider.editUser(context);
                                  Navigator.of(context).pop();
                                  emailIgnor = true;
                                  nameIgnor = true;
                                  setState2(() {});
                                });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
