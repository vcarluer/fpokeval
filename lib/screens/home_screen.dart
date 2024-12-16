import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokeval/providers/card_analysis_provider.dart';
import 'package:pokeval/widgets/header.dart';
import 'package:pokeval/widgets/image_uploader.dart';
import 'package:pokeval/widgets/loading_spinner.dart';
import 'package:pokeval/widgets/error_message.dart';
import 'package:pokeval/widgets/card_selection_panel.dart';
import 'package:pokeval/widgets/recognition_info.dart';
import 'package:pokeval/widgets/price_display.dart';
import 'package:pokeval/widgets/search_history.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pokemon-sketch-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Consumer<CardAnalysisProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      const Header(),
                      const SizedBox(height: 24),
                      
                      if (!provider.hasRecognizedInfo && 
                          !provider.hasFoundCards && 
                          !provider.hasAnalyzedCard) ...[
                        ImageUploader(
                          onImageSelect: provider.handleImageSelect,
                          isLoading: provider.isAnalyzing,
                        ),
                        const SizedBox(height: 24),
                        const SearchHistory(),
                      ],

                      if (provider.isAnalyzing)
                        LoadingSpinner(
                          message: provider.analysisStep,
                          subMessage: provider.currentProgress,
                        ),

                      if (provider.error != null)
                        ErrorMessage(message: provider.error!),

                      if (provider.recognizedInfo != null && 
                          !provider.hasFoundCards && 
                          !provider.hasAnalyzedCard)
                        RecognitionInfo(info: provider.recognizedInfo!),

                      if (provider.foundCards != null && 
                          !provider.isAnalyzing)
                        CardSelectionPanel(
                          cards: provider.foundCards!,
                          onSelect: provider.handleCardSelection,
                          onBack: provider.resetState,
                          currentFile: provider.currentFile!,
                          recognizedInfo: provider.recognizedInfo,
                          searchMethod: provider.searchMethod,
                        ),

                      if (provider.analyzedCard != null && 
                          !provider.isAnalyzing)
                        PriceDisplay(
                          card: provider.analyzedCard!,
                          userCardImage: provider.currentFile != null 
                            ? provider.currentFile!.path 
                            : null,
                          searchMethod: provider.searchMethod,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}