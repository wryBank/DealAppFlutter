// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutterdealapp/model/postmodel.dart';
// import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
// import 'package:flutterdealapp/pages/post/bloc/post_event.dart';
// import 'package:flutterdealapp/pages/post/bloc/post_state.dart';

// // class filterPosts extends StatefulWidget {
// //   const filterPosts({super.key});

// //   @override
// //   State<filterPosts> createState() => _filterPostsState();
// // }

// // class _filterPostsState extends State<filterPosts> {
// //   final checkBoxList = [
// //     CheckBoxModal(
// //       title: 'รับจ้าง',
// //     ),
// //     CheckBoxModal(title: 'จ้างงาน'),
// //     CheckBoxModal(title: 'ดีลของฉัน'),
// //     CheckBoxModal(title: 'กำลังดำเนินงาน'),
// //     CheckBoxModal(title: 'สำเร็จแล้ว'),
// //   ];
// //   bool FindJob = false;
// //   bool HireJob = false;
// //   bool myDeal = false;
// //   bool inprogress = false;
// //   bool success = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         width: double.infinity,
// //         height: 250,
// //         // child: Column(
// //         //   children: checkBoxList
// //         //       .map((e) => ListTile(
// //         //             onTap: () {
// //         //               e.value = !e.value;
// //         //             },
// //         //             leading: Checkbox(
// //         //               value: e.value,
// //         //               onChanged: (value) => setState(() {
// //         //                 e.value = value!;
// //         //               }),
// //         //             ),
// //         //             title: Text(e.title),
// //         //           ))
// //         //       .toList(),
// //         // ),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: checkBoxList.asMap().entries.map((entry) {
// //               int idx = entry.key;
// //               CheckBoxModal e = entry.value;
// //               return ListTile(
// //                 onTap: () {
// //                   setState(() {
// //                     e.value = !e.value;
// //                     if (idx == 0)
// //                       FindJob = e.value;
// //                     else if (idx == 1)
// //                       HireJob = e.value;
// //                     else if (idx == 2)
// //                       myDeal = e.value;
// //                     else if (idx == 3)
// //                       inprogress = e.value;
// //                     else if (idx == 4) success = e.value;
// //                   });
// //                 },
// //                 leading: Checkbox(
// //                   value: e.value,
// //                   onChanged: (value) => setState(() {
// //                     e.value = !e.value;
// //                     if (idx == 0)
// //                       FindJob = e.value;
// //                     else if (idx == 1)
// //                       HireJob = e.value;
// //                     else if (idx == 2)
// //                       myDeal = e.value;
// //                     else if (idx == 3)
// //                       inprogress = e.value;
// //                     else if (idx == 4) success = e.value;

// //                   }),
// //                 ),
// //                 title: Text(e.title),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           print('findJob: $FindJob');
// //           print('HireJob: $HireJob');
// //           print('myDeal: $myDeal');
// //           print('inprogress: $inprogress');
// //           print('success: $success');

// //         },
// //         child: Icon(Icons.check),
// //       ),
// //       // floatingActionButtonLocation:
// //       //     FloatingActionButtonLocation.centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
// //     );
// //   }
// // }

// // class CheckBoxModal {
// //   String title;
// //   bool value;
// //   CheckBoxModal({required this.title, this.value = false});
// // }
// class filterPosts extends StatefulWidget {
//   @override
//   State<filterPosts> createState() => filterPostsState();
// }

// class filterPostsState extends State<filterPosts> {
//   List<bool> _postTypeSelected = [false, false, false];
//   List<bool> _statusSelected = [false, false, false];
//   List<bool> _typeSelected = [false, false, false];
//   bool inprogress= false;
//   bool statusAll = false;

//   bool isFindJob = false;
//   bool postTypeAll = false;

//   bool ownPost = false;
//   bool typeAll = false;

//   void _toggleSelection(List<bool> selectionList, int index) {
//     setState(() {
//       if (index == 2) {
//         // 'ทั้งหมด' option
//         final isSelected = !selectionList[2];
//         for (int i = 0; i < selectionList.length; i++) {
//           selectionList[i] = isSelected;
//         }
//       } else {
//         for (int i = 0; i < selectionList.length; i++) {
//           selectionList[i] = false;
//         }
//         selectionList[index] = true;
//       }

//       // Additional logic for status
//       if (selectionList == _statusSelected) {
//         inprogress = _statusSelected[0] && !_statusSelected[1];
//         statusAll = _statusSelected[2];
//       }
//       if (selectionList == _postTypeSelected) {
//         isFindJob = _postTypeSelected[0] && !_postTypeSelected[1];
//         postTypeAll = _postTypeSelected[2];
//       }
//       if (selectionList == _typeSelected) {
//         ownPost = _typeSelected[0] && !_typeSelected[1];
//         typeAll = _typeSelected[2];
        
//       }
//     });
//   }

//   void _printValues() {
//     print('Post Type Selected: $_postTypeSelected');
//     print('Status Selected: $_statusSelected');
//     print('Type Selected: $_typeSelected');
//     // print('Type Selected3: ${_typeSelected[2]}');
//     print('inprogress: $inprogress');
//     print('statusAll: $statusAll');
//     print('isFindJob: $isFindJob');
//     print('postTypeAll: $postTypeAll');
//     print('ownPost: $ownPost');
//     print('typeAll: $typeAll');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text('Checkbox Example')),
//       body: SingleChildScrollView(
//         // padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text('ประเภทของโพสต์', style: TextStyle(fontSize: 18)),
//             Row(
//               children: [
//                 Checkbox(
//                   value: _postTypeSelected[0],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_postTypeSelected, 0);
//                   },
//                 ),
//                 Text('รับจ้าง'),
//                 Checkbox(
//                   value: _postTypeSelected[1],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_postTypeSelected, 1);
//                   },
//                 ),
//                 Text('จ้างงาน'),
//                 Checkbox(
//                   value: _postTypeSelected[2],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_postTypeSelected, 2);
//                   },
//                 ),
//                 Text('ทั้งหมด'),
//               ],
//             ),
//             Text('สถานะ', style: TextStyle(fontSize: 18)),
//             Row(
//               children: [
//                 Checkbox(
//                   value: _statusSelected[0],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_statusSelected, 0);
//                   },
//                 ),
//                 Text('กำลังดำเนินการ'),
//                 Checkbox(
//                   value: _statusSelected[1],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_statusSelected, 1);
//                   },
//                 ),
//                 Text('สำเร็จแล้ว'),
//                 Checkbox(
//                   value: _statusSelected[2],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_statusSelected, 2);
//                   },
//                 ),
//                 Text('ทั้งหมด'),
//               ],
//             ),
//             Text('ประเภท', style: TextStyle(fontSize: 18)),
//             Row(
//               children: [
//                 Checkbox(
//                   value: _typeSelected[0],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_typeSelected, 0);
//                   },
//                 ),
//                 Text('โพสต์โดยฉัน'),
//                 Checkbox(
//                   value: _typeSelected[1],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_typeSelected, 1);
//                   },
//                 ),
//                 Text('รับงานโดยฉัน'),
//                 Checkbox(
//                   value: _typeSelected[2],
//                   onChanged: (bool? value) {
//                     _toggleSelection(_typeSelected, 2);
//                   },
//                 ),
//                 Text('ทั้งหมด'),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: (){
//                 getPostFilter2(context, isFindJob, postTypeAll, inprogress, statusAll, ownPost, typeAll);
//               },
//               child: Text('Print Values'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//  getPostFilter2(BuildContext context,
//   bool isFindJob,bool postTypeAll,bool inprogress, bool statusAll,bool ownPost,bool typeAll)
// {
//   BlocProvider.of<PostBloc>(context).add(getPostFilter(isFindJob, postTypeAll, inprogress, statusAll, ownPost, typeAll));
  
  
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_event.dart';

class filterPosts extends StatefulWidget {
  @override
  State<filterPosts> createState() => filterPostsState();
}

class filterPostsState extends State<filterPosts> {
  List<bool> _postTypeSelected = [false, false, false];
  List<bool> _statusSelected = [false, false, false];
  List<bool> _typeSelected = [false, false, false];

  bool inprogress = false;
  bool statusAll = false;

  bool isFindJob = false;
  bool postTypeAll = false;

  bool ownPost = false;
  bool typeAll = false;

  void _toggleSelection(List<bool> selectionList, int index) {
    setState(() {
      if (index == 2) {
        // 'ทั้งหมด' option
        final isSelected = !selectionList[2];
        for (int i = 0; i < selectionList.length; i++) {
          selectionList[i] = isSelected;
        }
      } else {
        for (int i = 0; i < selectionList.length; i++) {
          selectionList[i] = false;
        }
        selectionList[index] = true;
      }

      // Additional logic for status
      if (selectionList == _statusSelected) {
        inprogress = _statusSelected[0] && !_statusSelected[1];
        statusAll = _statusSelected[2];
      }
      if (selectionList == _postTypeSelected) {
        isFindJob = _postTypeSelected[0] && !_postTypeSelected[1];
        postTypeAll = _postTypeSelected[2];
      }
      if (selectionList == _typeSelected) {
        ownPost = _typeSelected[0] && !_typeSelected[1];
        typeAll = _typeSelected[2];
      }
    });
  }

  void _printValues() {
    print('Post Type Selected: $_postTypeSelected');
    print('Status Selected: $_statusSelected');
    print('Type Selected: $_typeSelected');
    print('inprogress: $inprogress');
    print('statusAll: $statusAll');
    print('isFindJob: $isFindJob');
    print('postTypeAll: $postTypeAll');
    print('ownPost: $ownPost');
    print('typeAll: $typeAll');
  }

  Widget _buildToggleButton(String text, List<bool> selectionList, int index) {
    return GestureDetector(
      onTap: () {
        _toggleSelection(selectionList, index);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: selectionList[index] ? Colors.blueAccent : Colors.white,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: selectionList[index] ? Colors.white : Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [
                            // Color.fromRGBO(161, 196, 253, 100),
                            // Color.fromRGBO(194, 233, 251, 100),
                            Color.fromRGBO(224, 195, 252, 100),
                            Color.fromRGBO(142, 197, 252, 100),
                            // Colors.white,
                          ],
                        ),
                      ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ประเภทของโพสต์', style: TextStyle(fontSize: 18)),
                Center(
                  child: Wrap(
                    children: [
                      _buildToggleButton('รับจ้าง', _postTypeSelected, 0),
                      _buildToggleButton('จ้างงาน', _postTypeSelected, 1),
                      _buildToggleButton('ทั้งหมด', _postTypeSelected, 2),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text('สถานะ', style: TextStyle(fontSize: 18)),
                Center(
                  child: Wrap(
                    children: [
                      _buildToggleButton('กำลังดำเนินการ', _statusSelected, 0),
                      _buildToggleButton('สำเร็จแล้ว', _statusSelected, 1),
                      _buildToggleButton('ทั้งหมด', _statusSelected, 2),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text('ประเภท', style: TextStyle(fontSize: 18)),
                Center(
                  child: Wrap(
                    children: [
                      _buildToggleButton('โพสต์โดยฉัน', _typeSelected, 0),
                      _buildToggleButton('รับงานโดยฉัน', _typeSelected, 1),
                      _buildToggleButton('ทั้งหมด', _typeSelected, 2),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    getPostFilter2(context, isFindJob, postTypeAll, inprogress, statusAll, ownPost, typeAll);
                  },
                  child: Text('Print Values'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void getPostFilter2(BuildContext context, bool isFindJob, bool postTypeAll, bool inprogress, bool statusAll, bool ownPost, bool typeAll) {
  BlocProvider.of<PostBloc>(context).add(getPostFilter(isFindJob, postTypeAll, inprogress, statusAll, ownPost, typeAll));
}
