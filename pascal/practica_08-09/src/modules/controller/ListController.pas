module ListController;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ListController.pas
    Provides the controller for lists
}

export	ListController = (
            listStudentsAlphabetically
);

import  Definitions qualified;
        StudentsListModel qualified;
        StudentModel qualified;
        StudentView qualified;
        ListSort qualified;

procedure listStudentsAlphabetically(var origin: Definitions.tStudentsList);

end;


procedure listStudentsAlphabetically;
var list: Definitions.tStudentsList;
    s: Definitions.tStudent;
    i: integer;
begin
    ListSort.sortStudents(origin, list);
    for i := 1 to StudentsListModel.getCount(list) do begin
        if StudentsListModel.get(list, i, s)
        then StudentView.print(StudentModel.getFirstName(s),
                               StudentModel.getLastName(s),
                               StudentModel.getLogin(s)
                              );
    end;
end;


end.