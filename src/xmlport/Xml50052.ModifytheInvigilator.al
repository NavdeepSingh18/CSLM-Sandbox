xmlport 50052 "Modify the Invigilator"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Invigilator Summary-CS"; "Invigilator Summary-CS")
            {
                AutoUpdate = true;
                RequestFilterFields = "Exam Schedule No.";
                XmlName = 'Invigilator';
                fieldelement(Docno; "Invigilator Summary-CS"."Doc No.")
                {
                }
                fieldelement(LineNo; "Invigilator Summary-CS"."Line No")
                {
                }
                fieldelement(AcademicYear; "Invigilator Summary-CS"."Academic Year")
                {
                }
                fieldelement(SubjetType; "Invigilator Summary-CS"."Subject Type")
                {
                }
                fieldelement(SubjectCode; "Invigilator Summary-CS"."Subject Code")
                {
                }
                fieldelement(TypeofCourse; "Invigilator Summary-CS"."Type Of Course")
                {
                }
                fieldelement(ExamDate; "Invigilator Summary-CS"."Exam Date")
                {
                }
                fieldelement(RoomAlloted; "Invigilator Summary-CS"."Room Alloted No.")
                {
                }
                fieldelement(ExamSlot; "Invigilator Summary-CS"."Exam Slot")
                {
                }
                fieldelement(Inivigilator1; "Invigilator Summary-CS"."Invigilator 1")
                {
                }
                fieldelement(Inivigilator2; "Invigilator Summary-CS"."Invigilator 2")
                {
                }
                fieldelement(Inivigilator3; "Invigilator Summary-CS"."Invigilator 3")
                {
                }
                fieldelement(Inivigilator4; "Invigilator Summary-CS"."Invigilator 4")
                {
                }
                fieldelement(ExamSchedule; "Invigilator Summary-CS"."Exam Schedule No.")
                {
                }
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

    trigger OnPostXmlPort()
    begin

        InvigilatorSummaryCS.Reset();
        IF InvigilatorSummaryCS.FINDSET() THEN
            REPEAT
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Exam Date", InvigilatorSummaryCS."Exam Date");
                ExternalAttendanceLineCS.SETRANGE("Exam Slot", InvigilatorSummaryCS."Exam Slot");
                ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                ExternalAttendanceLineCS.SETRANGE("Room Alloted No.", InvigilatorSummaryCS."Room Alloted No.");
                IF ExternalAttendanceLineCS.FINDFIRST() THEN
                    REPEAT
                        ExternalAttendanceLineCS."Invigilator 1" := InvigilatorSummaryCS."Invigilator 1";
                        ExternalAttendanceLineCS."Invigilator 2" := InvigilatorSummaryCS."Invigilator 2";
                        ExternalAttendanceLineCS."Invigilator 3" := InvigilatorSummaryCS."Invigilator 3";
                        ExternalAttendanceLineCS."Invigilator 4" := InvigilatorSummaryCS."Invigilator 4";
                        ExternalAttendanceLineCS.Modify();
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;

            UNTIL InvigilatorSummaryCS.NEXT() = 0;
        MESSAGE('Done')
    end;

    var
        InvigilatorSummaryCS: Record "Invigilator Summary-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
}

