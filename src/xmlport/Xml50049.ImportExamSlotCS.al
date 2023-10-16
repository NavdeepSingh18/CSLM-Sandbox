xmlport 50049 "Import Exam SlotCS"
{
    // version V.001-CS

    Caption = 'Import Bank Payment Voucher';
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
                XmlName = 'ScheduleLine';
                fieldelement(Doc; "Exam Time Table Line-CS"."Document No.")
                {
                }
                fieldelement(LineNo; "Exam Time Table Line-CS"."Line No.")
                {
                }
                fieldelement(SubCode; "Exam Time Table Line-CS"."Subject Code")
                {
                }
                fieldelement(CourseCode; "Exam Time Table Line-CS"."Course Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Exam Time Table Line-CS"."Course Code" := '0' + FORMAT("Exam Time Table Line-CS"."Course Code");
                    end;
                }
                fieldelement(SemesterCode; "Exam Time Table Line-CS"."Semester Code")
                {
                }
                fieldelement(SubType; "Exam Time Table Line-CS"."Subject Type")
                {
                }
                fieldelement(AcademicYear; "Exam Time Table Line-CS"."Academic Year")
                {
                }
                fieldelement(ExamDate; "Exam Time Table Line-CS"."Exam Date")
                {
                }
                fieldelement(ExamSlot; "Exam Time Table Line-CS"."Exam Slot New")
                {
                }

                trigger OnAfterInitRecord()
                begin
                    "Exam Time Table Line-CS"."Document No." := DocNO;
                    "Exam Time Table Line-CS".VALIDATE("Exam Time Table Line-CS"."Exam Slot New")
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

    var


        DocNO: Code[20];


    procedure GetDocNo(NO: Code[20])
    begin
        DocNO := NO;
    end;
}

