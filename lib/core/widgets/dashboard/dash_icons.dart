/// SVG asset paths for the dashboard icons (exported from Figma).
class DashIcons {
  const DashIcons._();

  static const _base = 'assets/images/dashboard';

  /// Full PrimeCare brand logo (mark + wordmark + tagline), white.
  /// A raster asset (the Figma export embeds a PNG), so render with `Image`.
  static const logo = '$_base/ic_logo.png';

  // Summary cards — Emergency
  static const ambulance = '$_base/ic_ambulance.svg';
  static const flag = '$_base/ic_flag.svg';
  static const passport = '$_base/ic_passport.svg';

  // Summary cards — Outpatient
  static const users = '$_base/ic_users.svg';
  static const cash = '$_base/ic_cash.svg';
  static const creditCard = '$_base/ic_credit_card.svg';

  // Summary cards / sections — HR
  static const totalStaff = '$_base/ic_total_staff.svg';
  static const doctors = '$_base/ic_doctors.svg';
  static const nursing = '$_base/ic_nursing.svg';
  static const staffCategory = '$_base/ic_staff_category.svg';

  // Revenue
  static const moneyBag = '$_base/ic_money_bag.svg';
  static const trendUp = '$_base/ic_trend_up.svg';
  static const trendDown = '$_base/ic_trend_down.svg';

  // Operating Room
  static const scissors = '$_base/ic_scissors.svg';
  static const heart = '$_base/ic_heart.svg';
  static const microscope = '$_base/ic_microscope.svg';
  static const check = '$_base/ic_check.svg';
  static const clock = '$_base/ic_clock.svg';
  static const xmark = '$_base/ic_xmark.svg';

  // Section headers
  static const pie = '$_base/ic_pie.svg';
  static const clipboard = '$_base/ic_clipboard.svg';

  // Chart card leading icons
  static const cashHand = '$_base/ic_cash_hand.svg';
  static const barChart = '$_base/ic_bar_chart.svg';

  // Status breakdown tiles — Emergency
  static const newArrival = '$_base/ic_new_arrival.svg';
  static const hourglass = '$_base/ic_hourglass.svg';
  static const inTreatment = '$_base/ic_in_treatment.svg';
  static const discharged = '$_base/ic_discharged.svg';
  static const admitted = '$_base/ic_admitted.svg';

  // Status breakdown tiles — Outpatient (newArrival + hourglass reused)
  static const cancel = '$_base/ic_cancel.svg';
  static const followUp = '$_base/ic_followup.svg';
  static const apology = '$_base/ic_apology.svg';

  // Badges
  static const barsLive = '$_base/ic_bars_live.svg';
}
