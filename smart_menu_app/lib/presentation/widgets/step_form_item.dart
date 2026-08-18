import 'package:flutter/material.dart';

class StepFormItem extends StatelessWidget {
  const StepFormItem({
    required this.index,
    required this.controller,
    required this.onRemove,
    super.key,
  });

  final int index;
  final TextEditingController controller;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '步骤 ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  tooltip: '删除步骤',
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: '步骤内容',
                hintText: '例如：鸡腿洗净并擦干。',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '步骤内容不能为空';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
