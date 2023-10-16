xmlport 50053 "Import Exam Slot New"
{
    // version V.001-CS

    Direction = Both;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Exam Time Table Line-CS"; "Exam Time Table Line-CS")
            {
                AutoUpdate = true;
                XmlName = 'ScheduleLine';
                fieldelement(DocumentNo; "Exam Time Table Line-CS"."Document No.")
                {
                }
                fieldelement(SubjectType; "Exam Time Table Line-CS"."Subject Type")
                {
                }
                fieldelement(LineNo; "Exam Time Table Line-CS"."Line No.")
                {
                }
                fieldelement(Program; "Exam Time Table Line-CS".Program)
                {
                }
                fieldelement(Semester; "Exam Time Table Line-CS"."Semester Code")
                {
                }
                fieldelement(Year; "Exam Time Table Line-CS".Year)
                {
                }
                fieldelement(SubjectCode; "Exam Time Table Line-CS"."Subject Code")
                {
                }
                fieldelement(SubjectName; "Exam Time Table Line-CS"."Subject Name")
                {
                }
                fieldelement(ExamDate; "Exam Time Table Line-CS"."Exam Date")
                {
                }
                fieldelement(EaxmSlot; "Exam Time Table Line-CS"."Exam Slot New")
                {
                }
                fieldelement(DepartmentCode; "Exam Time Table Line-CS"."Global Dimension 2 Code")
                {
                }

                trigger OnAfterInitRecord()
                begin
                    "Exam Time Table Line-CS"."Document No." := DocNO;
                end;
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
        InformationOfStudentCS.TimeSlotValidateCS();
        MESSAGE('Done');
    end;

    var

        // GenJourNarr: Record "Gen. Journal Narration";
        InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
        DocNO: Code[20];



    procedure GetDocNo(NO: Code[20])
    begin
        DocNO := NO;
    end;
}

