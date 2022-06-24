import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:montage/utils/dimens.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/utilites.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FeedBackView extends StatefulWidget {
  @override
  _FeedBackViewState createState() => _FeedBackViewState();
}

class _FeedBackViewState extends State<FeedBackView> implements ApiCallBacks {
  ApiPresenter apiPresenter;

  bool isLoading = false;

  dynamic _pickImageError;
  File _video;

  _FeedBackViewState() {
    apiPresenter = ApiPresenter(this);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var horizontalFeedList = [];
  List<XFile> uploadedList = <XFile>[];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final titleController = TextEditingController()..text = "";
  final emailController = TextEditingController()..text = "";
  final descController = TextEditingController()..text = "";

  @override
  void initState() {
    super.initState();
    clearAllList();
  }

  clearAllList() {
    setState(() {
      horizontalFeedList.clear();
      uploadedList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
      return Container(
        color: colorBackground,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                appBar(),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter email";
                    }
                    if (!validateEmail(value)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: descController,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 10,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                uploadFileCard(),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      debugPrint("success");
                      print("uploadedList : ${uploadedList.length}");
                      var userId =
                          await SessionManager.getStringData(WebFields.USER_ID);
                      Utilities.loading(context, status: true);
                      apiPresenter.feedBack(userId, titleController.text,
                          emailController.text, descController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: colorTheme),
                  child: Text("SUBMIT"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  appBar() {
    return SubPageAppBar(title: AppStrings.feedback);
  }

  uploadFileCard() {
    return Container(
      height: horizontalFeedList.isNotEmpty ? 320 : 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10.0),
            const Text('UPLOAD FILES',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20.0),
            DottedBorder(
              color: Colors.black,
              borderType: BorderType.RRect,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              strokeWidth: 1,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 2.5,
                child: ElevatedButton(
                  onPressed: () async {
                    showUploadDialog(context);
                  },
                  style: ElevatedButton.styleFrom(primary: colorTheme),
                  child: Row(
                    children: [
                      Text("Browse Files"),
                      const SizedBox(width: 20.0),
                      new Image.asset(
                        'assets/images/attachment.png',
                        height: 22,
                        width: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            horizontalFeedList.isNotEmpty
                ? uploadHorizontalListView(context)
                : Container(),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  uploadHorizontalListView(BuildContext context) {
    return horizontalFeedList == null || horizontalFeedList.length == 0
        ? Center(child: Text("DATA NOT FOUND"))
        : Expanded(
            child: ListView.builder(
                itemCount: horizontalFeedList.length,
                padding: EdgeInsets.only(
                    left: commonPadding,
                    right: commonPadding,
                    top: paddingSmall),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctxt, int index) => InkWell(
                    onTap: () {
                      debugPrint(index.toString());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: horizontalFeedList.length - index == 1
                              ? 0
                              : paddingSmall),
                      child: Container(
                        height: 120,
                        width: 100,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 120,
                                width: 100,
                                child: Image.file(
                                  File(horizontalFeedList[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                              onTap: () async {
                                await removeImage(horizontalFeedList[index]);
                                await removeUploadedList(uploadedList[index]);
                              },
                            )
                          ],
                        ),
                      ),
                    ))),
          );
  }

  Future removeImage(index) async {
    horizontalFeedList.remove(index);
    print("remove index horizontalFeedList =${horizontalFeedList.length}");
    setState(() {});
  }

  Future removeUploadedList(index) async {
    uploadedList.remove(index);
    print("remove index uploadedList =${uploadedList.length}");
    setState(() {});
  }

  showUploadDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            actions: <Widget>[
              Container(
                height: 100,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        getImage(context);
                      },
                      child: Column(children: [
                        const SizedBox(height: 20.0),
                        Icon(Icons.image_outlined,
                            size: 45, color: Colors.deepPurple),
                        const SizedBox(height: 05.0),
                        Text("Image"),
                      ]),
                    ),
                    InkWell(
                      onTap: () {
                        getVideo(context);
                      },
                      child: Column(children: [
                        const SizedBox(height: 20.0),
                        Icon(Icons.video_collection_outlined,
                            size: 45, color: Colors.deepPurple),
                        const SizedBox(height: 05.0),
                        Text("Video"),
                      ]),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              )
            ],
          );
        });
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {}

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    debugPrint("=====");
    debugPrint(object.toString());
    if (requestCode == RequestCode.FEEDBACK ||
        requestCode.contains(RequestCode.FEEDBACK)) {
      Toast.show('Feedback sent successfully ', context);
      Utilities.loading(context, status: false);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Future getVideo(BuildContext context) async {
    try {
      final XFile video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video.path.isNotEmpty) {
        _video = File(video.path);
        print("Size = ${_video.lengthSync()}");
        print(
            "SizeMB = ${filesize(_video.lengthSync()).substring(0, filesize(_video.lengthSync()).indexOf((' ')))}");
        uploadedList.add(XFile(video.path));
        print("uploadedList after video =$uploadedList");
      }

      final fileName = await VideoThumbnail.thumbnailFile(
        video: _video.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 64,
        // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 75,
      );
      var thumbnailName = XFile(fileName).path;
      if (uploadedList != null) {
        horizontalFeedList.add(thumbnailName);
      }
      if (horizontalFeedList != null) {
        print("horizontalFeedList after video =$horizontalFeedList");
        Navigator.of(context).pop(true);
        //uploadFile(_image);
      }
      setState(() {});
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future getImage(BuildContext context) async {
    try {
      final List<XFile> selectedImages = await _picker.pickMultiImage(
        imageQuality: 20,
      );
      if (selectedImages.isNotEmpty) {
        uploadedList.addAll(selectedImages);
        print("uploadedList=$uploadedList");
      }

      if (uploadedList.isNotEmpty) {
        for (int i = 0; i < uploadedList.length; i++) {
          horizontalFeedList.add(uploadedList[i].path);
        }
        print("horizontalFeedList after Image=$horizontalFeedList");
        Navigator.of(context).pop(true);
      }
      setState(() {});
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
}
