const String GOOGLE_MAP_API_KEY='AIzaSyDXEr4PlguKm9WbpQK57HDwnAeSSkUE_lI';

class LocationHelper
{
  static String mapImageUrl({required double latitude, required double longitude})
  {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_MAP_API_KEY";
  }
}
