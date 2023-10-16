xmlport 50082 StudentOnGroundCheckIn
{
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'StudentOnGroundCheckIn';
                textelement(EnrollmentNo)
                {

                }

                trigger OnBeforeInsertRecord()
                var
                    StudentOnGroundCheckIn_lRec: Record StudentOnGroundCheckIn;
                    StudentMaster_lRec: Record "Student Master-CS";
                    OLRUpdateLine_lRec: Record "OLR Update Line";
                Begin
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end ELSE begin
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("Enrollment No.", EnrollmentNo);
                        If StudentMaster_lRec.FindFirst() then
                            StudentMaster_lRec.TestField("OLR Completed");

                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("Enrollment No.", EnrollmentNo);
                        If StudentMaster_lRec.FindFirst() then
                            StudentMaster_lRec.TestField("Student Group", StudentMaster_lRec."Student Group"::" ");


                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("Enrollment No.", EnrollmentNo);
                        IF StudentMaster_lRec.FindFirst() then begin
                            If StudentMaster_lRec."Returning Student" then begin
                                OLRUpdateLine_lRec.Reset();
                                OLRUpdateLine_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                                IF OLRUpdateLine_lRec.FindFirst() then begin
                                    IF OLRUpdateLine_lRec.Confirmed then begin
                                        StudentOnGroundCheckIn_lRec.Reset();
                                        StudentOnGroundCheckIn_lRec.SetRange(StudentNo, OLRUpdateLine_lRec."Student No.");
                                        StudentOnGroundCheckIn_lRec.SetRange("OLR Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                                        StudentOnGroundCheckIn_lRec.SetRange("OLR Term", OLRUpdateLine_lRec."OLR Term");
                                        IF Not StudentOnGroundCheckIn_lRec.FindFirst() then begin
                                            StudentOnGroundCheckIn_lRec.Init();
                                            StudentOnGroundCheckIn_lRec.StudentNo := OLRUpdateLine_lRec."Student No.";
                                            StudentOnGroundCheckIn_lRec."OLR Academic Year" := OLRUpdateLine_lRec."OLR Academic Year";
                                            StudentOnGroundCheckIn_lRec."OLR Semester" := OLRUpdateLine_lRec."OLR Semester";
                                            StudentOnGroundCheckIn_lRec."OLR Term" := OLRUpdateLine_lRec."OLR Term";
                                            StudentOnGroundCheckIn_lRec.Insert();
                                        end;
                                    end Else
                                        //OLRUpdateLine_lRec.TestField(Confirmed);
                                        Error('Firstly confirmed OLR process for the student : %1 whose document no. is %2', OLRUpdateLine_lRec."Student No.", OLRUpdateLine_lRec."Document No.");
                                end Else begin
                                    //Error('Firstly do OLR process for returning student whose Enrollment No : %1', EnrollmentNo);
                                    StudentOnGroundCheckIn_lRec.Reset();
                                    StudentOnGroundCheckIn_lRec.SetRange(StudentNo, StudentMaster_lRec."No.");
                                    StudentOnGroundCheckIn_lRec.SetRange("OLR Academic Year", StudentMaster_lRec."Academic Year");
                                    StudentOnGroundCheckIn_lRec.SetRange("OLR Term", StudentMaster_lRec.Term);
                                    IF Not StudentOnGroundCheckIn_lRec.FindFirst() then begin
                                        StudentOnGroundCheckIn_lRec.Init();
                                        StudentOnGroundCheckIn_lRec.StudentNo := StudentMaster_lRec."No.";
                                        StudentOnGroundCheckIn_lRec."OLR Academic Year" := StudentMaster_lRec."Academic Year";
                                        StudentOnGroundCheckIn_lRec."OLR Semester" := StudentMaster_lRec.Semester;
                                        StudentOnGroundCheckIn_lRec."OLR Term" := StudentMaster_lRec.Term;
                                        StudentOnGroundCheckIn_lRec.Insert();
                                    end;
                                end;

                            end Else begin
                                StudentOnGroundCheckIn_lRec.Reset();
                                StudentOnGroundCheckIn_lRec.SetRange(StudentNo, StudentMaster_lRec."No.");
                                StudentOnGroundCheckIn_lRec.SetRange("OLR Academic Year", StudentMaster_lRec."Academic Year");
                                StudentOnGroundCheckIn_lRec.SetRange("OLR Term", StudentMaster_lRec.Term);
                                IF Not StudentOnGroundCheckIn_lRec.FindFirst() then begin
                                    StudentOnGroundCheckIn_lRec.Init();
                                    StudentOnGroundCheckIn_lRec.StudentNo := StudentMaster_lRec."No.";
                                    StudentOnGroundCheckIn_lRec."OLR Academic Year" := StudentMaster_lRec."Academic Year";
                                    StudentOnGroundCheckIn_lRec."OLR Semester" := StudentMaster_lRec.Semester;
                                    StudentOnGroundCheckIn_lRec."OLR Term" := StudentMaster_lRec.Term;
                                    StudentOnGroundCheckIn_lRec.Insert();
                                end;
                            end;
                        end;


                    end;
                    currXMLport.Skip();
                End;
            }
        }
    }
    Var
        SkipFirstLine: Boolean;


}