import 'package:flutter/material.dart';
class Usertile extends StatelessWidget {
  final title;
  final icon;
  final VoidCallback func;
  Usertile(this.title,this.icon,this.func);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: func,
       visualDensity: VisualDensity(horizontal: 0, vertical: -2),
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 121, 31, 109),
        child: Icon(icon,color: Colors.white,),
      ),
      title: Text(title),
      trailing: IconButton(icon: Icon(Icons.navigate_next),onPressed: (){},),
    );
  }
}