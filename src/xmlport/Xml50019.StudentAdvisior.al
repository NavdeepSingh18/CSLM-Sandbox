xmlport 50019 "Student Advisor Details"
{
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Student Advisor Details"; "Student Advisor Details")
            {
                XmlName = 'StudentAdvisorUpload';

                TextElement(EmployeeMatser)
                {
                    MinOccurs = Zero;
                }
                TextElement(StudentNo)
                {
                    MinOccurs = Zero;

                }

                // fieldelement(SubjectNo; "Student Advisor Details"."Student No.")
                // {

                // }
                // fieldelement(EmployeeMaster; "Student Advisor Details"."Advisor No.")
                // {
                // }
                trigger OnAfterInsertRecord()
                begin
                    Counter := Counter + 1;
                    Window.UPDATE(1, "Student Advisor Details"."Student No.");
                    //  Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                    CounterOK := CounterOK + 1;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    // CounterTotal := "Student Advisor Details".count();
                    Window.OPEN(Text0001Lbl);
                    StudentMaster.Reset();
                    //StudentMaster.SetRange("Global Dimension 1 Code", '9100');
                    StudentMaster.SetRange(StudentMaster."Original Student No.", StudentNo);
                    IF StudentMaster.FindFirst() then begin
                        RecStudentAdvisorDetails.Reset();
                        RecStudentAdvisorDetails.Init();
                        RecStudentAdvisorDetails.Validate("Student No.", StudentMaster."No.");
                        RecStudentAdvisorDetails.Validate("Advisor No.", EmployeeMatser);
                        RecStudentAdvisorDetails.Insert(true);
                    end else
                        Error('Student : %1 does not found.', StudentNo);
                    currXMLport.SKIP();
                end;


                // trigger OnAfterInitRecord()
                // var

                //     StudentMaster: Record "Student Master-CS";
                // begin
                //     StudentMaster.Reset();
                //     StudentMaster.SetRange("Global Dimension 1 Code", '9100');
                //     StudentMaster.SetRange(StudentMaster."Original Student No.", StudentNo);
                //     IF StudentMaster.FindFirst() then begin
                //         "Student Advisor Details".Validate("Student No.", StudentMaster."No.");
                //         "Student Advisor Details".Validate("Advisor No.", EmployeeMatser);
                //     end else
                //         Error('Student Does not Exist %1', StudentNo);

                // end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
    trigger OnPreXmlPort()
    begin

    end;

    trigger OnPostXmlPort()
    var
    begin
        Window.CLOSE();
        MESSAGE('Upload Sucessfully !');
    end;


    var
        RecStudentAdvisorDetails: Record "Student Advisor Details";
        StudentMaster: Record "Student Master-CS";
        // DocNo: Code[20];
        // Section: Code[10];
        // CourseCode: Code[20];
        // Semester: Code[10];
        // AcaYr: Code[20];
        // GD1: Code[20];
        Counter: Integer;
        Window: Dialog;
        // CounterTotal: Integer;
        CounterOK: Integer;
        // FirstLine: Boolean;
        Text0001Lbl: Label 'Uploading Students  #1########## @2@@@@@@@@@@@@@';
    // VTerm: Option "FALL","SPRING","SUMMER";
    // VYear: Code[10];

}