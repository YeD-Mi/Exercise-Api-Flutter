import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/exercise_view_model.dart';

class ExerciseView extends StatelessWidget {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 80.0,
            title: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: TextField(
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          hintText: 'Search...',
                          hintStyle:
                              (TextStyle(color: Colors.black, fontSize: 18)),
                        ),
                        //onChanged: ,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.tune,
                            color: Colors.black,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black26,
                  height: 600,
                  child: Center(
                      child: context.watch<ExerciseViewModel>().state ==
                              ExerciseState.BUSY
                          ? buildLoadingWidget()
                          : context.watch<ExerciseViewModel>().state ==
                                  ExerciseState.ERROR
                              ? buildErrorWidget()
                              : buildListView(context)),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Center buildErrorWidget() => Center(child: Text('Something went wrong!'));

  Center buildLoadingWidget() => Center(child: CircularProgressIndicator());

  ListView buildListView(BuildContext context) {
    return ListView.builder(
        itemCount: 10, //length atılacak.
        itemBuilder: (_, index) => buildListItem(context, index));
  }

  Widget buildListItem(BuildContext context, int index) {
    final exercise = context.read<ExerciseViewModel>().exerciseList![index];
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            exercise.name!,
            textScaleFactor: 1.2,
          ),
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black26,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                border: Border.all(color: Colors.black),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(exercise.type!, style: TextStyle(fontSize: 13)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(exercise.muscle!, style: TextStyle(fontSize: 16)),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
