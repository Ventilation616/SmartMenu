enum IngredientType {
  main('主料'),
  side('辅料'),
  seasoning('调味料'),
  garnish('点缀'),
  other('其他');

  const IngredientType(this.label);

  final String label;
}
