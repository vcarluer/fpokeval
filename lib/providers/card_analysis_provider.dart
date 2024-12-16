import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pokeval/models/pokemon_card.dart';
import 'package:pokeval/models/tcg_card.dart';
import 'package:pokeval/services/card_analysis_service.dart';
import 'package:pokeval/services/card_search_service.dart';

class CardAnalysisProvider extends ChangeNotifier {
  bool _isAnalyzing = false;
  String? _analysisStep;
  String? _error;
  PokemonCard? _analyzedCard;
  File? _currentFile;
  List<TcgCard>? _foundCards;
  String? _searchMethod;
  Map<String, dynamic>? _recognizedInfo;
  List<String> _searchProgress = [];

  // Getters
  bool get isAnalyzing => _isAnalyzing;
  String? get analysisStep => _analysisStep;
  String? get error => _error;
  PokemonCard? get analyzedCard => _analyzedCard;
  File? get currentFile => _currentFile;
  List<TcgCard>? get foundCards => _foundCards;
  String? get searchMethod => _searchMethod;
  Map<String, dynamic>? get recognizedInfo => _recognizedInfo;
  String get currentProgress => 
    _searchProgress.isNotEmpty ? _searchProgress.last : '';

  bool get hasRecognizedInfo => _recognizedInfo != null;
  bool get hasFoundCards => _foundCards != null;
  bool get hasAnalyzedCard => _analyzedCard != null;

  Future<void> handleImageSelect(File file) async {
    _resetState();
    _isAnalyzing = true;
    _currentFile = file;
    _analysisStep = 'Analyse des textes de l\'image';
    notifyListeners();

    try {
      final result = await CardAnalysisService.analyzeCard(file);
      
      if (result.name == null) {
        throw Exception('Impossible de reconnaître le nom de la carte');
      }

      _recognizedInfo = {
        'name': result.name,
        'englishName': result.englishName,
        'subtype': result.subtype,
        'hp': result.hp,
        'cardFound': false,
      };
      _analysisStep = 'Recherche par similitude des images';
      notifyListeners();

      final searchResult = await CardSearchService.searchCard(
        result.name!,
        result.subtype,
        result.hp,
        file,
        _updateSearchProgress,
      );

      if (searchResult.cards.isEmpty) {
        throw Exception('Aucune carte correspondante trouvée');
      }

      _searchMethod = searchResult.searchMethod;

      if (searchResult.cards.length == 1) {
        final cardResult = await CardAnalysisService.analyzePokemonCard(
          file,
          searchResult.cards.first,
        );
        
        if (cardResult.success && cardResult.card != null) {
          _analyzedCard = cardResult.card;
          _recognizedInfo = {..._recognizedInfo!, 'cardFound': true};
        } else {
          throw Exception(cardResult.error ?? 'Erreur lors de l\'analyse');
        }
      } else {
        _foundCards = searchResult.cards;
        _recognizedInfo = {..._recognizedInfo!, 'cardFound': true};
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }

  void _updateSearchProgress(String strategy) {
    _searchProgress = [..._searchProgress, "Recherche avec la stratégie $strategy"];
    notifyListeners();
  }

  Future<void> handleCardSelection(TcgCard card) async {
    if (_currentFile == null) return;

    _isAnalyzing = true;
    _analysisStep = 'Analyse de la carte sélectionnée';
    notifyListeners();

    try {
      final result = await CardAnalysisService.analyzePokemonCard(
        _currentFile!,
        card,
      );
      
      if (result.success && result.card != null) {
        _analyzedCard = result.card;
        _foundCards = null;
      } else {
        throw Exception(result.error ?? 'Une erreur est survenue lors de l\'analyse');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }

  void resetState() {
    _isAnalyzing = false;
    _analysisStep = null;
    _error = null;
    _analyzedCard = null;
    _currentFile = null;
    _foundCards = null;
    _searchMethod = null;
    _recognizedInfo = null;
    _searchProgress = [];
    notifyListeners();
  }
}