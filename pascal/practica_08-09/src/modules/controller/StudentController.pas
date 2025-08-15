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
            newStudent,
            updateStudent
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
procedure updateStudent;

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

procedure updateStudent;
var idx: integer;
    key: Definitions.tPersonalInfo;
    student: Definitions.tStudent;
begin
    StudentView.getLogin(key);
    idx := StudentsListModel.find(studentsList, key);
    if idx = 0
    then writeln('Student not found')
    else begin
        if StudentsListModel.get(studentsList, idx, student)
        then begin
            writeln;
            writeln('Updating student:');
            StudentView.print(StudentModel.getFirstName(student),
                            StudentModel.getLastName(student),
                            StudentModel.getLogin(student));
            case StudentView.getPersonalInfoField of
                1: begin
                    StudentView.getFirstName(key);
                    StudentModel.setFirstName(student, key);
                end;
                2: begin
                    StudentView.getLastName(key);
                    StudentModel.setLastName(student, key);
                end;
                3: writeln('Student login cannot be changed');
            end;
            if StudentsListModel.put(studentsList, idx, student)
            then writeln('Student updated successfully')
            else writeln('Could not update student');
        end
        else writeln('Student could not be retrieved');
    end;
end;

end.