class ApiConfig {
  static const tcgApiKey = String.fromEnvironment('TCG_API_KEY');
  static const openaiApiKey = String.fromEnvironment('OPENAI_API_KEY');

  static const analysisPrompt = '''
Analyse cette carte Pokémon et retourne uniquement un objet JSON avec cette structure exacte, sans texte additionnel :
{
  "name": "nom du pokemon en français",
  "englishName": "nom du pokemon en anglais",
  "subtype": "type de la carte (GX/V/VMAX/etc si présent, sinon null)",
  "hp": "points de vie (nombre uniquement, sans le texte HP)"
}
''';
}