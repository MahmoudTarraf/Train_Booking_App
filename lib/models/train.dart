class Train {
  final String trainName;
  final String stationName;
  final String onBoardingTime;
  final String returningTime;
  final int trainNumber;
  int numberOfAvailablePassengers;
  final String id;
  final String destinationTo;
  final String destinationFrom;
  final String listOfStops;
  int ticketPrice;
  final String tripDate;

  Train({
    required this.tripDate,
    required this.ticketPrice,
    required this.listOfStops,
    required this.destinationFrom,
    required this.destinationTo,
    required this.id,
    required this.trainName,
    required this.trainNumber,
    required this.numberOfAvailablePassengers,
    required this.onBoardingTime,
    required this.returningTime,
    required this.stationName,
  });
}
