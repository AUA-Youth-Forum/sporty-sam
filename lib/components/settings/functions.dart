import 'package:country_picker/country_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void showCountries(context,userID) {
  showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) => {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .update({'country': country.displayName})
      });
}
void updateGender(String? newValue,userID){
  try {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .update({'gender': newValue});
  } catch (e) {
    print(e.toString());
  }
}
void updateBirthday(context,userID,currentDate){
  DatePicker.showDatePicker(context,
      theme: DatePickerTheme(
        containerHeight: 210.0,
      ),
      showTitleActions: true,
      minTime: DateTime(1950, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        try {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .update(
              {'birthday': date.toString()});
        } catch (e) {
          print('abcd');
          print(e.toString());
        }
      },
      currentTime: DateTime.parse(
          currentDate),
      locale: LocaleType.en);
}
