import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';

class CountryPicker extends StatefulWidget {
  final Function(String?)? state;
  final Function(String?)? city;
  final Function(String?)? country;
  const CountryPicker({super.key, this.state, this.city, this.country});

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      showStates: true,
      showCities: true,
      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      disabledDropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      countrySearchPlaceholder: "Country",
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",
      countryDropdownLabel: "Country",
      stateDropdownLabel: "State",
      cityDropdownLabel: "City",
      // countryFilter: [CscCountry.Pakistan],
      selectedItemStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownHeadingStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      dropdownItemStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      currentCity: context
              .watch<BaseVm>()
              .additionalInfoModel
              ?.contactInfo
              ?.shippingAddress
              ?.city ??
          "",
      currentCountry: context
              .watch<BaseVm>()
              .additionalInfoModel
              ?.contactInfo
              ?.shippingAddress
              ?.country ??
          "",
      currentState: context
              .watch<BaseVm>()
              .additionalInfoModel
              ?.contactInfo
              ?.shippingAddress
              ?.city ??
          "",
      defaultCountry: CscCountry.Pakistan,
      onCountryChanged: (value) {
        setState(() {
          countryValue = value;
        });
        widget.country!(value);
        // Print the selected country to the debug console
        print("Selected Country: $countryValue");
      },
      onStateChanged: (value) {
        setState(() {
          stateValue = value;
        });
        widget.state!(value);
        // Print the selected state to the debug console
        print("Selected State: $stateValue");
      },
      onCityChanged: (value) {
        setState(() {
          cityValue = value;

          widget.city!(cityValue);
        });

        // Print the selected city to the debug console
        print("Selected City: $cityValue");
      },
    );
  }
}
