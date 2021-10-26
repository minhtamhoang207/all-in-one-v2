class AddNoteState{
  final String? title;
  final String? description;
  final int? price;
  final int? type;
  final int? createAt;
  final FormSubmissionStatus? formStatus;

  AddNoteState({
    this.title = '',
    this.description = '',
    this.price = 0,
    this.type,
    this.createAt,
    this.formStatus = FormSubmissionStatus.InitialFormStatus
  });

  AddNoteState copyWith({
     String? title,
     String? description,
     int? price,
     int? type,
     int? createAt,
     FormSubmissionStatus? formStatus,
  }){
    return AddNoteState(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      createAt: createAt ?? this.createAt,
      formStatus: formStatus ?? this.formStatus,
    );
  }


}

enum FormSubmissionStatus{
  InitialFormStatus,
  FormSubmitting,
  SubmissionSuccess,
  SubmissionFailed
}