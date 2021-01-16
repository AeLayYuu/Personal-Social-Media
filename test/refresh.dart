@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldstate,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.ten_k),
              onPressed: () {
                print("file>>>>>>>>>$file");
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 0),
              Expanded(
                child: FutureBuilder(
                    future: getAllCommentData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                            reverse: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onLongPress: () {
                                  deleteAlertDialog(snapshot.data[index].id);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          child: Icon(Icons.person)),
                                      title: Text(snapshot.data[index].text),
                                      trailing: Text(snapshot.data[index].path),
                                    ),
                                    snapshot.data[index].photo != "No File"
                                        ? Container(
                                            width: 300,
                                            height: 300,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '$commentphotoUrl/${snapshot.data[index].photo}',
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) =>
                                                  Container(
                                                      width: double.infinity,
                                                      height: 400,
                                                      color: Colors.grey),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Container(
                                                      color: Colors.grey[200],
                                                      height: 300,
                                                      width: double.infinity,
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.error))),
                                            ),
                                          )
                                        : SizedBox(height: 0),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                            itemCount: snapshot.data.length);
                      }
                    }),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  file != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Card(
                            elevation: 30,
                            child: Container(
                              width: 150,
                              height: reviewPhotoHeight,
                              child: Image.file(File(file.path),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        )
                      : Container(height: 0),
                  Column(
                    children: [
                      Container(
                        decoration: kMessageContainerDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                controller: messageTextController,
                                onChanged: (value) {
                                  //   messageText = value;
                                },
                                decoration: kMessageTextFieldDecoration,
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Container(
                                color: Colors.blue[500],
                                child: FlatButton(
                                  onPressed: () {
                                    //////////////////DateTime
                                    String dateTime = DateTime.now().toString();
                                    String noSpaceDate =
                                        "/${dateTime.replaceAll(new RegExp(r"\s+"), "_")}";
                                    String underschoolDate = noSpaceDate
                                        .split("/")
                                        .last
                                        .replaceAll(".", "_");
                                    realDate =
                                        "${widget.path}_IMG_$underschoolDate.jpg";

                                    //////////////////DateTime
                                    if (messageTextController.text.length > 0) {
                                      if (file == null) {
                                        insertMethodNoFile(
                                            messageTextController.text,
                                            "No File");
                                        _fleshLoading();
                                      } else {
                                        insertMethod(messageTextController.text,
                                            realDate);
                                        setState(() {
                                          reviewPhotoHeight = 0;
                                        });
                                      }

                                      messageTextController.clear();
                                    } else {
                                      _showErrorSnackBarMsg(
                                          "Please enter comment...");
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'Send',
                                      style: kSendButtonTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 3, top: 3, bottom: 3),
                            child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.black12,
                                child: IconButton(
                                  onPressed: () {
                                    getFromCamera();
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                    size: 27,
                                    color: Colors.blue,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 3, top: 3, bottom: 3),
                            child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.black12,
                                child: IconButton(
                                  onPressed: () {
                                    getFromGallery();
                                    setState(() {
                                      reviewPhotoHeight = 150;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.image,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 3, top: 3, bottom: 3),
                            child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.black12,
                                child: IconButton(
                                  onPressed: () {
                                    //////////////////DateTime

                                    String dateTime = DateTime.now().toString();
                                    String noSpaceDate =
                                        "/${dateTime.replaceAll(new RegExp(r"\s+"), "_")}";
                                    String underschoolDate = noSpaceDate
                                        .split("/")
                                        .last
                                        .replaceAll(".", "_");
                                    realDate =
                                        "${widget.path}_IMG_$underschoolDate.jpg";

                                    //////////////////DateTime
                                    _showLoadingSnackBarMsg("Loading......");
                                    startUpload(realDate, "001");
                                  },
                                  icon: Icon(
                                    Icons.video_call,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 3, top: 3, bottom: 3),
                            child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.black12,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.pin_drop,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 3, top: 3, bottom: 3),
                            child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.black12,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }