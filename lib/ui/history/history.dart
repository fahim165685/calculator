import 'package:calculator/ui/history/history_list.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context);
        },
        backgroundColor: Colors.white,
        child:const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

      appBar: AppBar(
        title: Text("H I S T O R Y",style: TextStyle(color: Colors.purple)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:(infoList.isEmpty) ?
      Center(child:Column(
        children: [
          const SizedBox(height: 150,),
          Image.network("https://cdn-icons-png.flaticon.com/512/32/32223.png",color: Colors.black.withOpacity(0.1),height: 300,),
          const SizedBox(height: 70, ),
          const Text("NO HISTORY",style: TextStyle(fontSize: 30,color: Colors.black38),)
        ],
      ) )

          :Container(
        child: ListView.builder(
              itemCount:infoList.length,
              itemBuilder: (BuildContext context,index){
                return  historyCard(history:infoList[index],);
              }),
      ),
    );
  }

  Container historyCard({required HistoryInfo history}) {
    return Container(
          width: double.infinity,
          padding:const EdgeInsets.all(10),
          margin:const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
          decoration:  BoxDecoration(
            color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1),offset: const Offset(5,5),blurRadius: 10)],
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      infoList.removeAt(0);
                    });
                  },
                  icon: const Icon(Icons.delete,color: Colors.grey,)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(history.result,style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text('= ${history.input}',style:  TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.4)

                  ),)
                ],
              ),
            ],
          ),

        );
  }
}
