import 'package:flutter/material.dart';

class ListInfo extends StatelessWidget {
  const ListInfo({required this.data, required this.imgUrl, super.key});
  final String imgUrl;
  final int data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imgUrl,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text("Kote asatiani"),
                  Row(
                    children: [
                      Text("$data videos"),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.public,
                        color: Colors.grey,
                      ),
                      const Text("public"),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    color: Colors.grey,
                    splashRadius: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.file_download_sharp),
                    color: Colors.grey,
                    splashRadius: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send_sharp),
                    color: Colors.grey,
                    splashRadius: 20,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text("Play"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
