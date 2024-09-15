part of 'address_checkbox_bloc.dart';

class AddressCheckBoxState {
  final String? selectedDocumentId;

  AddressCheckBoxState({this.selectedDocumentId});

  // Helper method to check if a specific document is selected
  bool isSelected(String documentId) {
    return selectedDocumentId == documentId;
  }
}
