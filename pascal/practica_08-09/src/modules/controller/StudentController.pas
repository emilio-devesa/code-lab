module StudentController;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    StudentController.pas
    Provides the controller for the student model
}

export	StudentController = (
            studentsList,
            loadStudents,
            saveStudents,
            newStudent
);

import  StandardOutput;
        Definitions qualified;
        StudentModel qualified;
        StudentsListModel qualified;
        StudentView qualified;
        StudentPersistence qualified;

var     studentsList: Definitions.tStudentsList;

procedure loadStudents;
procedure saveStudents;        
procedure newStudent;

end;

procedure loadStudents;
begin
    if StudentPersistence.loadFromFile(studentsList)
    then writeln('Data loaded successfully')
    else writeln('Data could not be loaded');
end;

procedure saveStudents;
begin
    if StudentPersistence.saveToFile(studentsList)
    then writeln('Data saved successfully')
    else writeln('Data could not be saved');
end;

procedure newStudent;
var student: Definitions.tStudent; s: Definitions.tPersonalInfo;
begin
    StudentView.getFirstName(s);
    StudentModel.setFirstName(student, s);
    StudentView.getLastName(s);
    StudentModel.setLastName(student, s);
    StudentView.getLogin(s);
    StudentModel.setLogin(student, s);
    if StudentsListModel.add(studentsList, student)
    then writeln('Student added successfully')
    else writeln('Could not add new student');
end;


end.