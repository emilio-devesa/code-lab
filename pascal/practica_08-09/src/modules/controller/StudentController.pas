module StudentController;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    StudentController.pas
    Provides the controller for the student model
}

export	StudentController = (
            loadStudents,
            saveStudents,
            newStudent,
            updateStudent
);

import  StandardOutput;
        Definitions qualified;
        Operations qualified;
        StudentModel qualified;
        StudentsListModel qualified;
        StudentView qualified;
        StudentPersistence qualified;
        GradesService qualified;


procedure loadStudents(var studentsList: Definitions.tStudentsList);
procedure saveStudents(var studentsList: Definitions.tStudentsList);        
procedure newStudent(var studentsList: Definitions.tStudentsList);
procedure updateStudent(var studentsList: Definitions.tStudentsList; var gradesList: Definitions.tGradesList);

end;

procedure loadStudents;
begin
    if StudentPersistence.loadFromFile(studentsList)
    then writeln('Students loaded successfully.')
    else writeln('Students could not be loaded.');
end;

procedure saveStudents;
begin
    if StudentPersistence.saveToFile(studentsList)
    then writeln('Students saved successfully.')
    else writeln('Students could not be saved.');
end;

procedure newStudent;
{ Adds a new student to the students list. }
{ The student is created from the data entered by the user. }
var student: Definitions.tStudent; s: Definitions.tPersonalInfo;
begin
    StudentView.getFirstName(s);
    StudentModel.setFirstName(student, s);
    StudentView.getLastName(s);
    StudentModel.setLastName(student, s);
    StudentView.getLogin(s);
    StudentModel.setLogin(student, s);
    if StudentsListModel.find(studentsList, s) > 0
    then writeln('Student can not be added: There is already an student with this login.')
    else begin
        if StudentsListModel.add(studentsList, student)
        then begin
            writeln('Student created.');
            saveStudents(studentsList);
        end
        else writeln('Could not create new student.');
    end;
    Operations.WaitForEnter;
    Operations.ClearScreen;
end;

procedure updateStudent;
{ Updates a student in the students list.
  If the student has grades, it updates the login in the grades list too. }
var idx: integer;
    key, aux: Definitions.tPersonalInfo;
    student: Definitions.tStudent;
    aborted: boolean value false;
begin
    writeln;
    writeln('-------------------------');
    writeln('Update student');
    writeln('Enter student login or leave blank to go back to Main Menu');
    writeln('-------------------------');
    StudentView.getLogin(key);
    idx := StudentsListModel.find(studentsList, key);
    if idx = 0
    then begin
        if key = ''
        then aborted := true
        else writeln('Student not found.');
    end
    else begin
        if StudentsListModel.get(studentsList, idx, student)
        then begin
            writeln;
            writeln('Updating student:');
            StudentView.print(StudentModel.getFirstName(student), StudentModel.getLastName(student), StudentModel.getLogin(student));
            case StudentView.getPersonalInfoField of
                1: begin
                    StudentView.getFirstName(key);
                    StudentModel.setFirstName(student, key);
                end;
                2: begin
                    StudentView.getLastName(key);
                    StudentModel.setLastName(student, key);
                end;
                3: begin
                    aux := StudentModel.getLogin(student);
                    StudentView.getLogin(key);
                    StudentModel.setLogin(student, key);
                    if GradesService.loginExists(gradesList, aux) 
                    then begin
                        writeln('Updating login in grades list.');
                        GradesService.updateLogin(gradesList, aux, key);
                    end
                    else writeln('Login not found in grades list, no update made.');
                end;
                0: aborted := true;
            end;
            if (not aborted) and (StudentsListModel.put(studentsList, idx, student))
            then begin
                writeln('Student updated successfully.');
                saveStudents(studentsList);
            end
            else writeln('Student was´t updated.');
        end
        else writeln('Student could not be retrieved.');
    end;
    Operations.WaitForEnter;
    Operations.ClearScreen;
end;

end.