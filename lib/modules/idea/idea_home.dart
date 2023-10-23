import 'package:flutter/material.dart';
import 'package:idea/modules/idea/idea_detail.dart';
import 'package:idea/modules/idea/provider/idea_provider.dart';
import 'package:idea/modules/shared/navigation_utils.dart';
import 'package:provider/provider.dart';

class IdeaHome extends StatefulWidget {
  const IdeaHome({super.key});

  @override
  State<IdeaHome> createState() => _IdeaHomeState();
}

class _IdeaHomeState extends State<IdeaHome> {
  @override
  void initState() {
    context.read<IdeaProvider>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                addIdeaScreen(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          IdeaProvider().getData();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<IdeaProvider>(
                builder: (BuildContext context, provider, widget) {
                  if (provider.idea.isEmpty == true) {
                    return const Center(
                        child: Text(
                      'Your idea list is empty',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.idea.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                color: Colors.blueGrey.shade200,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                        // width: 130,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            RichText(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: TextSpan(
                                                  text: 'Title: ',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .blueGrey.shade800,
                                                      fontSize: 16.0),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            '${provider.idea[index].title}\n',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ]),
                                            ),
                                            RichText(
                                              maxLines: 1,
                                              text: TextSpan(
                                                  text: 'Downvotes: ',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .blueGrey.shade800,
                                                      fontSize: 16.0),
                                                  children: [
                                                    // TextSpan(
                                                    //     text:
                                                    //         '${provider.idea[index].downvotes}',
                                                    //     style: const TextStyle(
                                                    //         fontWeight:
                                                    //             FontWeight.bold)),
                                                    WidgetSpan(
                                                      child:
                                                          ValueListenableBuilder<
                                                                  int>(
                                                              valueListenable:
                                                                  provider
                                                                      .idea[
                                                                          index]
                                                                      .downvotes!,
                                                              builder: (context,
                                                                  val, child) {
                                                                return Text(val
                                                                    .toString());
                                                              }),
                                                    )
                                                  ]),
                                            ),
                                            RichText(
                                              maxLines: 1,
                                              text: TextSpan(
                                                  text: 'Upvotes: ',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .blueGrey.shade800,
                                                      fontSize: 16.0),
                                                  children: [
                                                    WidgetSpan(
                                                      child:
                                                          ValueListenableBuilder<
                                                                  int>(
                                                              valueListenable:
                                                                  provider
                                                                      .idea[
                                                                          index]
                                                                      .upvotes!,
                                                              builder: (context,
                                                                  val, child) {
                                                                return Text(val
                                                                    .toString());
                                                              }),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      ValueListenableBuilder<int>(
                                          valueListenable:
                                              provider.idea[index].upvotes!,
                                          builder: (context, val, child) {
                                            return Text(val.toString());
                                          }),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          provider.upVote(
                                              provider.idea[index].id!.toInt());
                                        },
                                        child: const Icon(
                                          Icons.thumb_up,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      ValueListenableBuilder<int>(
                                          valueListenable:
                                              provider.idea[index].downvotes!,
                                          builder: (context, val, child) {
                                            return Text(val.toString());
                                          }),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          provider.downVote(
                                              provider.idea[index].id!.toInt());
                                        },
                                        child: const Icon(
                                          Icons.thumb_down,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await provider.fetchIdea(provider
                                                .idea[index].id!
                                                .toInt());
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => IdeaDetail(
                                                          title: provider.detail
                                                                  ?.title ??
                                                              '',
                                                          description: provider
                                                                  .detail
                                                                  ?.description ??
                                                              '',
                                                          downvotes: provider
                                                                  .detail
                                                                  ?.downvotes
                                                                  ?.value
                                                                  .toString() ??
                                                              '0',
                                                          upvotes: provider
                                                                  .detail
                                                                  ?.upvotes
                                                                  ?.value
                                                                  .toString() ??
                                                              '0',
                                                        )));
                                          },
                                          icon: const Icon(
                                            Icons.remove_red_eye,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
