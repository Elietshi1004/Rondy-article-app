import 'package:flutter/material.dart';

class ListArticle extends StatefulWidget {
  const ListArticle({super.key});

  @override
  State<ListArticle> createState() => _ListArticleState();
}

class _ListArticleState extends State<ListArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste Produit'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
            
            },
            
          ))
        ],
      ),
    );
  }
}