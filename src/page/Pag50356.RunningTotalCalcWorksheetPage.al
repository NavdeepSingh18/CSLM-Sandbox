page 50356 RunningTotalCalc
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Discipline Level-CS";
    Caption = 'Running Total Calculation Sheet';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Control120)
            {
                ShowCaption = false;
                field(InstituteCode; InstituteCode)
                {
                    Caption = 'Institute Code';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                }
                field(AcademicYear; AcademicYear)
                {
                    Caption = 'Academic Year';
                    TableRelation = "Academic Year Master-CS";

                }
                field(SemesterCode; SemesterCode)
                {
                    Caption = 'Semester';
                    TableRelation = "Semester Master-CS";

                }
                field(pTerm; pTerm)
                {
                    Caption = 'Term';

                }

            }
            repeater(GroupName)
            {
                Editable = false;
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;

                }
                field("SLcM No."; Rec."SLcM No.")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Field01; Rec.Field01)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(12);

                }
                field(Field02; Rec.Field02)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(13);
                    Visible = ShowField;
                }
                field(Field03; Rec.Field03)
                {
                    ApplicationArea = all;
                    CaptionClass = '3,' + FieldCaptionClass(14);
                    Visible = ShowField;
                }
                field(Field04; Rec.Field04)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(15);
                    Visible = ShowField;
                }
                field(Field05; Rec.Field05)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(16);
                    Visible = ShowField;
                }
                field(Field06; Rec.Field06)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(17);
                    Visible = ShowField;
                }
                field(Field07; Rec.Field07)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(18);
                    Visible = ShowField;
                }
                field(Field08; Rec.Field08)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(19);
                    Visible = ShowField;
                }
                field(Field09; Rec.Field09)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(20);
                    Visible = ShowField;
                }
                field(Field10; Rec.Field10)
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + FieldCaptionClass(21);
                    Visible = false;
                }
                Field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

            action(CheckData)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Visible = false;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                var
                    RunningTotalCalcRec: Record "Enquiry Type-CS";
                    ExaminationMgmt: codeunit "Examination Management";
                begin
                    RunningTotalCalcRec.Reset();
                    RunningTotalCalcRec.DeleteAll();
                    Clear(ExaminationMgmt);
                    ExaminationMgmt.RunningTotalCalcMapping();
                end;
            }

            action(ResetData)
            {
                ApplicationArea = All;
                Visible = false;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                var
                    RunningTotalCalcRec: Record "Discipline Level-CS";
                    ExaminationMgmt: codeunit "Examination Management";
                begin
                    RunningTotalCalcRec.Reset();
                    RunningTotalCalcRec.DeleteAll();
                end;
            }

            action(GetData)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = False;
                trigger OnAction();
                var
                    RunningTotalCalcRec: Record "Enquiry Type-CS";
                    ExaminationMgmt: codeunit "Examination Management";
                    lTerm: Option FALL,SPRING,SUMMER;
                begin

                    Clear(ExaminationMgmt);
                    If pTerm = pTerm::FALL then
                        ExaminationMgmt.RunningTotalCalcData(SemesterCode, AcademicYear, lTerm::FALL, InstituteCode);
                    If pTerm = pTerm::SPRING then
                        ExaminationMgmt.RunningTotalCalcData(SemesterCode, AcademicYear, lTerm::SPRING, InstituteCode);
                    if pTerm = pTerm::SUMMER then
                        ExaminationMgmt.RunningTotalCalcData(SemesterCode, AcademicYear, lTerm::SUMMER, InstituteCode);
                    CurrPage.Update();
                end;
            }
        }
    }

    Var
        InstituteCode: Code[20];
        AcademicYear: Code[20];
        SemesterCode: Code[20];
        pTerm: Option FALL,SPRING,SUMMER;
        ShowField: Boolean;

    procedure FieldCaptionClass(FieldNo: Integer): Text
    var
        RunningTotalDataMapping: Record "Enquiry Type-CS";
    begin

        RunningTotalDataMapping.Reset();
        RunningTotalDataMapping.SetRange("Semester Code", SemesterCode);
        RunningTotalDataMapping.SetRange("Table ID", 50019);
        RunningTotalDataMapping.SetRange("Field ID", FieldNo);
        If RunningTotalDataMapping.FindFirst() then begin

            exit(RunningTotalDataMapping."Subject Code" + '/' + Format(RunningTotalDataMapping."Total Maximum"));
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        ShowField := true;
        Rec.SetFilter("Academic Year", AcademicYear);
        Rec.SetFilter(Semester, SemesterCode);
        IF (AcademicYear <> '') or (SemesterCode <> '') then
            Rec.SetRange(Term, pTerm);
    End;
}