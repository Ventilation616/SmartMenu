enum IngredientUnit {
  gram('g'),
  milliliter('ml'),
  piece('个'),
  tablespoon('勺'),
  teaspoon('茶匙'),
  other('其他');

  const IngredientUnit(this.label);

  final String label;
}
