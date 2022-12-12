import 'package:flutter/material.dart';
import 'package:food_ppopgi/common/common.dart';
import 'package:food_ppopgi/data/food/food_data_repository.dart';
import 'package:food_ppopgi/pages/main/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterRequestPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterRequestPageState();
}

class _RegisterRequestPageState extends ConsumerState<RegisterRequestPage> {
  final _controller = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(foodRepository);

    return Scaffold(
        appBar: AppBar(
          title: Text('요청사항 작성'),
          centerTitle: true,
        ),
        floatingActionButton: RegisterButton(
          text: '보내기',
          onTap: () async {
            try {
              if (_controller.text.isEmpty) {
                showDefaultSnackBar(
                  context,
                  content: '내용을 작성해주세요!',
                );
                return;
              }

              setState(() {
                _loading = true;
              });

              await repository.registerRequest(_controller.text);

              setState(() {
                _loading = false;
              });

              Navigator.pop(context);

              showDefaultSnackBar(
                context,
                content: '요청에 성공했습니다.\n빠른 시일내로 반영하도록 하겠습니다!',
              );
            } catch (e) {
              setState(() {
                _loading = false;
              });

              showDefaultSnackBar(
                context,
                content: '오류가 발생했습니다.\n잠시 후 다시 시도해주세요.',
              );
            }
          },
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  const Text(
                    '필요한 기능이 있으면 의견을 전달해주세요!\n검토 후 적극 반영하도록 하겠습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            if (_loading)
              Positioned.fill(
                child: Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
          ],
        ));
  }
}
