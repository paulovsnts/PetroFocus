// Tradução do PetroFocus Design System (Claude Design) para Flutter.
// Fonte: projeto "PetroFocus design system mobile" — PetroFocus Design System.dc.html
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta de cores do design system. Dark-only — o design não define modo claro.
abstract class AppColors {
  // Superfícies & texto
  static const Color background = Color(0xFF0B0E13);
  static const Color surface = Color(0xFF151B23);
  static const Color surfaceElevated = Color(0xFF1C2430);
  static const Color border = Color(0xFF2A3341);
  static const Color textPrimary = Color(0xFFEDF0F4);
  static const Color textSecondary = Color(0xFF8D97A5);
  static const Color textTertiary = Color(0xFF5B6572);

  // Estados do timer — Foco vs. Descanso
  static const Color foco = Color(0xFF2F6FED);
  static const Color focoDim = Color(0xFF1B3A73);
  static const Color descanso = Color(0xFFF5A524);
  static const Color descansoDim = Color(0xFF4A3311);

  // Estados de resposta — Acerto vs. Erro
  static const Color acerto = Color(0xFF2FBF83);
  static const Color acertoDim = Color(0xFF113325);
  static const Color erro = Color(0xFFF1495B);
  static const Color erroDim = Color(0xFF3A1620);
}

/// Escala de espaçamento — unidade base de 4px.
abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double huge = 64;

  /// Margem de conteúdo padrão (mobile).
  static const double contentMargin = 20;

  /// Gutter entre cards (12–16px no design; usar 16 como padrão).
  static const double cardGutter = 16;
}

/// Raios de borda por categoria de componente.
abstract class AppRadius {
  static const double card = 16;
  static const double button = 12;
  static const double pill = 999;
}

/// Escala tipográfica: Manrope para UI/leitura, IBM Plex Mono para números
/// que precisam de destaque imediato (cronômetro, nota líquida, métricas).
abstract class AppTypography {
  // Números de destaque (IBM Plex Mono)
  static TextStyle get displayTimer => GoogleFonts.ibmPlexMono(
        fontSize: 72,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: AppColors.textPrimary,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get displayNotaLiquida => GoogleFonts.ibmPlexMono(
        fontSize: 44,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get metricNumber => GoogleFonts.ibmPlexMono(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get monoLabel => GoogleFonts.ibmPlexMono(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
      );

  // Texto de interface (Manrope)
  static TextStyle get h1 => GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.15,
        color: AppColors.textPrimary,
      );

  static TextStyle get h2 => GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.6,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySecondary => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.72, // 0.06em
        color: AppColors.textTertiary,
      );

  static TextStyle get buttonLabel => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      );
}

/// Cores semânticas sem equivalente direto em [ColorScheme] (estados de
/// timer e de resposta). Acesse via `Theme.of(context).extension<PetroFocusColors>()`.
@immutable
class PetroFocusColors extends ThemeExtension<PetroFocusColors> {
  const PetroFocusColors({
    required this.foco,
    required this.focoDim,
    required this.descanso,
    required this.descansoDim,
    required this.acerto,
    required this.acertoDim,
    required this.erro,
    required this.erroDim,
    required this.surfaceElevated,
    required this.textTertiary,
  });

  final Color foco;
  final Color focoDim;
  final Color descanso;
  final Color descansoDim;
  final Color acerto;
  final Color acertoDim;
  final Color erro;
  final Color erroDim;
  final Color surfaceElevated;
  final Color textTertiary;

  static const light = PetroFocusColors(
    foco: AppColors.foco,
    focoDim: AppColors.focoDim,
    descanso: AppColors.descanso,
    descansoDim: AppColors.descansoDim,
    acerto: AppColors.acerto,
    acertoDim: AppColors.acertoDim,
    erro: AppColors.erro,
    erroDim: AppColors.erroDim,
    surfaceElevated: AppColors.surfaceElevated,
    textTertiary: AppColors.textTertiary,
  );

  @override
  PetroFocusColors copyWith({
    Color? foco,
    Color? focoDim,
    Color? descanso,
    Color? descansoDim,
    Color? acerto,
    Color? acertoDim,
    Color? erro,
    Color? erroDim,
    Color? surfaceElevated,
    Color? textTertiary,
  }) {
    return PetroFocusColors(
      foco: foco ?? this.foco,
      focoDim: focoDim ?? this.focoDim,
      descanso: descanso ?? this.descanso,
      descansoDim: descansoDim ?? this.descansoDim,
      acerto: acerto ?? this.acerto,
      acertoDim: acertoDim ?? this.acertoDim,
      erro: erro ?? this.erro,
      erroDim: erroDim ?? this.erroDim,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      textTertiary: textTertiary ?? this.textTertiary,
    );
  }

  @override
  PetroFocusColors lerp(ThemeExtension<PetroFocusColors>? other, double t) {
    if (other is! PetroFocusColors) return this;
    return PetroFocusColors(
      foco: Color.lerp(foco, other.foco, t)!,
      focoDim: Color.lerp(focoDim, other.focoDim, t)!,
      descanso: Color.lerp(descanso, other.descanso, t)!,
      descansoDim: Color.lerp(descansoDim, other.descansoDim, t)!,
      acerto: Color.lerp(acerto, other.acerto, t)!,
      acertoDim: Color.lerp(acertoDim, other.acertoDim, t)!,
      erro: Color.lerp(erro, other.erro, t)!,
      erroDim: Color.lerp(erroDim, other.erroDim, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
    );
  }
}

/// [ThemeData] do PetroFocus. Único tema — o design system é dark-only.
abstract class AppTheme {
  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.foco,
      onPrimary: AppColors.background,
      secondary: AppColors.descanso,
      onSecondary: AppColors.background,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.erro,
      onError: AppColors.background,
      outline: AppColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.manrope().fontFamily,

      textTheme: TextTheme(
        headlineLarge: AppTypography.h1,
        titleLarge: AppTypography.h2,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.bodySecondary,
        labelLarge: AppTypography.buttonLabel,
        labelSmall: AppTypography.caption,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.h2,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.foco,
          foregroundColor: AppColors.background,
          disabledBackgroundColor: AppColors.focoDim,
          textStyle: AppTypography.buttonLabel,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          textStyle: AppTypography.buttonLabel,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          textStyle: AppTypography.buttonLabel,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: AppTypography.bodySecondary,
        labelStyle: AppTypography.bodySecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: AppColors.foco, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
          borderSide: const BorderSide(color: AppColors.erro),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        side: const BorderSide(color: AppColors.border),
        labelStyle: AppTypography.caption,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),

      extensions: const [PetroFocusColors.light],
    );
  }
}
