import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ungcamp_signup/models/event.dart';
import 'package:ungcamp_signup/widgets/formInputs/number_input_form_field.dart';
import 'package:ungcamp_signup/widgets/formInputs/text_input_form_field.dart';

class CreateEvent extends StatefulWidget {

  final Function onSave;
  final String organizerId;

  CreateEvent({required this.organizerId, required this.onSave});

  @override
  _CreateEventState createState() => _CreateEventState(organizerId: organizerId, onSave: onSave);
}

class _CreateEventState extends State<CreateEvent> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();

  late FocusNode? focusNode;
  
  final _formKey = GlobalKey<FormState>();

  final Function onSave;
  final String organizerId;

  _CreateEventState({required this.organizerId, required this.onSave});

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    // We request focus and unfocus immediately to remove focus from other Widgets
    focusNode!.requestFocus();
    focusNode!.unfocus();
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2022));
    if (selectedDate != null) {
      DateFormat formatter = DateFormat('dd-MM');
      setState(() => _dateController.text = formatter.format(selectedDate));
    }
  }

  _selectTime(BuildContext context) async {
    focusNode!.requestFocus();
    focusNode!.unfocus();
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _timeController.value.text.isNotEmpty
          ? TimeOfDay(
              // TODO: This might break on non-danish locales...
              hour: int.parse(_timeController.text.substring(0, 2)),
              minute: int.parse(_timeController.text.substring(3, 5))
            )
          : TimeOfDay.now()
    );
    if (selectedTime != null) {
      _timeController.text = selectedTime.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Opret nyt møde',
              style: TextStyle(
                  fontSize: 20.0
              ),
            ),
            TextInputFormField(
              controller: _titleController,
              label: 'Title',
              hint: 'Titlen for mødet',
            ),
            TextInputFormField(
              controller: _typeController,
              label: 'Mødetype',
              hint: 'Morgenmøde, Aftenmøde osv...',
            ),
            TextInputFormField(
              controller: _descriptionController,
              label: 'Beskrivelse',
              hint: 'Kort beskrivelse af mødet',
            ),
            TextInputFormField(
              controller: _authorController,
              label: 'Taler',
              hint: 'Navnet på taleren for mødet',
            ),
            NumberInputFormField(
              controller: _participantsController,
              label: 'Antal pladser',
              hint: 'Maximum antal pladser for mødet, f.eks. 500',
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Dato'
                  ),
                  controller: _dateController,
                  focusNode: focusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Dato er påkrævet';
                    }
                    return null;
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Tidspunkt'
                  ),
                  controller: _timeController,
                  focusNode: focusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidspunkt er påkrævet';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Annuller'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UcEvent event = UcEvent(
                        key: 'tmp',
                        organizerId: organizerId,
                        title: _titleController.text,
                        type: _typeController.text,
                        description: _descriptionController.text,
                        author: _authorController.text,
                        atTime: _timeController.text,
                        atDate: _dateController.text,
                        maxParticipants: int.parse(_participantsController.text)
                      );
                      onSave(event);
                    }
                  },
                  child: Text('Gem'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
