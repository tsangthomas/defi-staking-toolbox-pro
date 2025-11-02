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
      'Esta aplicación es solo para fines educativos, no para consejos de inversión. Los cálculos y la IA pueden tener errores; verifique de forma independiente.';

  @override
  String get agree => 'Aceptar';

  @override
  String get theme => 'Tema';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get dashboardScreen => 'Pantalla del panel';

  @override
  String get chartsPlaceholder => 'Los gráficos estarán aquí';

  @override
  String get stakingPrograms => 'Programas de Staking';

  @override
  String get programListPlaceholder =>
      'La lista de programas de staking estará aquí';

  @override
  String get addStakingProgram => 'Agregar programa de staking';

  @override
  String get toolsScreen => 'Pantalla de herramientas';

  @override
  String get english => 'Inglés';

  @override
  String get chinese => 'Chino';

  @override
  String get japanese => 'Japonés';

  @override
  String get korean => 'Coreano';

  @override
  String get spanish => 'Español';

  @override
  String get chineseSimplified => 'Chino (simplificado)';

  @override
  String get chineseTraditional => 'Chino (tradicional)';

  @override
  String get aiAnalysis => 'Análisis de IA';

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
  String get totalRewards => 'Totalrecompensas';

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

  @override
  String get status => 'Estado';

  @override
  String get endDate => 'Fecha de Fin';

  @override
  String get selectDate => 'Seleccionar Fecha';

  @override
  String get details => 'Detalles';

  @override
  String get initialBalance => 'Saldo Inicial';

  @override
  String get currentBalance => 'Saldo Actual';

  @override
  String get gasFee => 'Tarifa de gas';

  @override
  String get walletPlatform => 'Billetera / Plataforma';

  @override
  String get startStaking => 'Comenzar Staking';

  @override
  String get unstake => 'Retirar Staking';

  @override
  String get addToBalance => 'Agregar al saldo';
}
