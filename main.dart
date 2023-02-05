import 'package:flutter/material.dart';

void main() => runApp(MemoApp());

class MemoApp extends StatefulWidget {
  const MemoApp({Key? key}) : super(key: key);

  @override
  State<MemoApp> createState() => _MemoAppState();
}

class _MemoAppState extends State<MemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memo',
      home: Memo(),
    );
  }
}

class Memo extends StatefulWidget {
  const Memo({Key? key}) : super(key: key);

  @override
  State<Memo> createState() => _MemoState();
}

class TextData {
  String title = '';
  bool isDone = false;

  TextData(this.title);
}

class _MemoState extends State<Memo> {
  List item = <TextData>[];
  var ctr = TextEditingController();

  addMemo(TextData w) {
    if (w.title.isEmpty) {
      return;
    }
    setState(() {
      item.add(w);
      ctr.clear();
      FocusScope.of(context).unfocus();
    });
  }

  deleteMemo(TextData w) {
    setState(() {
      item.remove(w);
    });
  }

  toggleMemo(TextData w) {
   setState(() {
     w.isDone = !w.isDone;
   });
  }

  Widget MemoText(TextData w) {
    return ListTile(
        title: Text(
          w.title,
          style: w.isDone
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontStyle: FontStyle.italic,
                )
              : null,
        ),
        onTap: () {
          toggleMemo(w);
        },
        trailing: IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            deleteMemo(w);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모장'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: item.map((e) => MemoText(e)).toList(),
            )),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: ctr,
                )),
                ElevatedButton(
                    onPressed: () {
                      addMemo(TextData(ctr.text));
                    },
                    child: Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
