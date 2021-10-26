class EditNoteState{
  final int? id;
  final String? title;
  final String? description;
  final int? price;
  final int? type;
  final int? createAt;
  final FormEditStatus? formStatus;

  EditNoteState({
    this.id,
    this.title = '',
    this.description = '',
    this.price = 0,
    this.type,
    this.createAt,
    this.formStatus = FormEditStatus.InitialFormStatus
  });

  EditNoteState copyWith({
    int? id,
    String? title,
    String? description,
    int? price,
    int? type,
    int? createAt,
    FormEditStatus? formStatus,
  }){
    return EditNoteState(
      id: id?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      createAt: createAt ?? this.createAt,
      formStatus: formStatus ?? this.formStatus,
    );
  }


}

enum FormEditStatus{
  InitialFormStatus,
  FormSubmitting,
  SubmissionSuccess,
  SubmissionFailed
}