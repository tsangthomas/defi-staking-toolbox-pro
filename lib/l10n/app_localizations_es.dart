// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'DeFi Staking Toolbox Pro';

  @override
  String get dashboard => 'Tablero';

  @override
  String get portfolio => 'Portafolio';

  @override
  String get tools => 'Herramientas';

  @override
  String get settings => 'Configuración';

  @override
  String get disclaimerTitle => 'Descargo de responsabilidad';

  @override
  String get disclaimerText =>
      'This app is for educational purposes only, not investment advice. Calculations and AI may have errors; verify independently.';

  @override
  String get agree => 'Agree';

  @override
  String get theme => 'Tema';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Idioma';

  @override
  String get dashboardScreen => 'Dashboard Screen';

  @override
  String get chartsPlaceholder => 'Charts will be here';

  @override
  String get stakingPrograms => 'Staking Programs';

  @override
  String get programListPlaceholder => 'Staking program list will be here';

  @override
  String get addStakingProgram => 'Add Staking Program';

  @override
  String get toolsScreen => 'Tools Screen';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get japanese => 'Japanese';

  @override
  String get korean => 'Korean';

  @override
  String get spanish => 'Spanish';

  @override
  String get chineseSimplified => 'Chinese (Simplified)';

  @override
  String get chineseTraditional => 'Chinese (Traditional)';

  @override
  String get aiAnalysis => 'AI Analysis';

  @override
  String get disclaimerContent =>
      'Esta es una versión beta de la aplicación. Todas las funciones son solo para fines experimentales y educativos. No lo use con activos reales.';

  @override
  String get accept => 'Aceptar';

  @override
  String get decline => 'Rechazar';

  @override
  String get portfolioTrackerTitle => 'Rastreador de Portafolio';

  @override
  String get noStakingItems => 'No hay elementos de staking';

  @override
  String get addStakingItemsToGetStarted =>
      'Agregue elementos de staking para comenzar';

  @override
  String get totalStaked => 'Total en Staking';

  @override
  String get totalRewards => 'Recompensas Totales';

  @override
  String get avgApy => 'APY Promedio';

  @override
  String get portfolioDistribution => 'Distribución del Portafolio';

  @override
  String get stakingPositions => 'Posiciones de Staking';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get staked => 'En Staking';

  @override
  String get startDate => 'Fecha de Inicio';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return 'Elemento de staking para $coin eliminado';
  }

  @override
  String get confirmDeletion => 'Confirmar Eliminación';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return 'Estás seguro de que quieres eliminar el elemento de staking para $coin?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get addStaking => 'Agregar Staking';

  @override
  String get editStaking => 'Editar Staking';

  @override
  String get coin => 'Moneda';

  @override
  String get validator => 'Validador';

  @override
  String get balance => 'Saldo';

  @override
  String get lockPeriod => 'Período de Bloqueo (días)';

  @override
  String get stakingAddress => 'Dirección de Staking (opcional)';

  @override
  String get estimatedApy => 'APY Estimado (%)';

  @override
  String get save => 'Guardar';

  @override
  String get fieldCannotBeEmpty => 'El campo no puede estar vacío';

  @override
  String get invalidNumber => 'Número inválido';

  @override
  String get invalidApy => 'APY inválido';

  @override
  String get addStakingDetails =>
      'Agregue los detalles de su nueva posición de staking.';

  @override
  String get editStakingDetails =>
      'Edite los detalles de su posición de staking.';
}
