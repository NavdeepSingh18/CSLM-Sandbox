page 50192 "Selection Academic Year-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    18-05-2019    Academic Year - OnLookup            Select and Update Field.
    // 2         CSPL-00092    18-05-2019    Institute Code - OnLookup           Select and Update Field.

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            field("Term"; CurrentTerm)
            {
                Caption = 'Term';
                OptionCaption = 'FALL,SPRING,SUMMER';
                ApplicationArea = All;
                Editable = false;
                trigger OnValidate()
                begin
                    IF CurrentTerm = CurrentTerm::SPRING then
                        NextTerm := NextTerm::FALL
                    else
                        NextTerm := NextTerm::SPRING;

                    CurrentAcademicYear := '';
                    NextAcademicYear := '';
                End;
            }
            field("Next Term"; NextTerm)
            {
                Caption = 'Next Term';
                OptionCaption = 'FALLSEMESTER,SPRINGSEMESTER';
                ApplicationArea = All;
                Editable = false;
            }
            field("Academic Year"; CurrentAcademicYear)
            {
                Caption = 'Current Academic Year';
                ApplicationArea = All;
                Editable = false;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    //Code added for Select and Update Field::CSPL-00092::18-05-2019: Start
                    AcademicYearMasterCS.Reset();
                    AcademicYearMasterCS.SETCURRENTKEY(Code);
                    IF AcademicYearMasterCS.FINDSET() THEN begin
                        IF PAGE.RUNMODAL(0, AcademicYearMasterCS) = ACTION::LookupOK THEN begin
                            CurrentAcademicYear := AcademicYearMasterCS.Code;

                            AcademicYearMasterCS1.Reset();
                            AcademicYearMasterCS1.SetRange(Code, CurrentAcademicYear);
                            IF AcademicYearMasterCS1.FindFirst() then
                                SequenceNo := AcademicYearMasterCS1.Sequence;

                            IF SequenceNo <> 0 Then begin
                                AcademicYearMasterCS1.Reset();
                                AcademicYearMasterCS1.SetRange(Sequence, (SequenceNo + 1));
                                IF AcademicYearMasterCS1.FindFirst() then
                                    NextAcademicYear := AcademicYearMasterCS1.Code;
                            end;
                        end;
                    end;
                    //Code added for Select and Update Field::CSPL-00092::18-05-2019: End
                end;
            }
            field("Next Academic Year"; NextAcademicYear)
            {
                Caption = 'Next Academic Year';
                ApplicationArea = All;
                Editable = false;
            }
            field("Institute Code"; InstituteCode1)
            {
                Caption = 'Institute Code';
                ApplicationArea = All;
                Editable = false;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    //Code added for Select and Update Field::CSPL-00092::18-05-2019: Start
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE("Dimension Code", 'INSTITUTE');
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        InstituteCode1 := DimensionValue.Code;
                    //Code added for Select and Update Field::CSPL-00092::18-05-2019: End
                end;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Generate)
            {
                Image = CreateInteraction;
                Promoted = true;
                Visible = false;
                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
                begin
                    //Code added for Call Function for Student Promotion::CSPL-00092::18-05-2019: Start

                    IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
                        IF CurrentAcademicYear <> '' THEN
                            InformationOfStudentCS.GenerateStudentPromotionCS(CurrentAcademicYear, InstituteCode1)
                        ELSE
                            ERROR('Select Academic Year');
                        CurrPage.Close();
                    END;
                    //Code added for Call Function for Student Promotion::CSPL-00092::18-05-2019: End
                end;
            }
            action("Generate Promotion Detail")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ExaminationManagement: Codeunit "Examination Management";
                begin
                    UserSetup.Get(UserId);
                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                    IF EducationSetup.FindFirst() then begin
                        IF CurrentAcademicYear <> EducationSetup."Academic Year" then
                            Error('%1 Current Academic Year should be same Education Setup Academic Year %2', CurrentAcademicYear, EducationSetup."Academic Year");
                        IF CurrentTerm <> EducationSetup."Even/Odd Semester" then
                            Error('%1 Current Semester Type should be same Education Setup Semester Type %2', CurrentTerm, EducationSetup."Even/Odd Semester");
                        IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
                            ExaminationManagement.StudentPromotionHeader("CurrentAcademicYear", NextAcademicYear, CurrentTerm, NextTerm, InstituteCode1);
                            Message('Promotion Document has been Generated');
                            CurrPage.Close();
                        end;
                    END;
                End;

            }
        }
    }

    var
        DimensionValue: Record "Dimension Value";
        AcademicYearMasterCS: Record "Academic Year Master-CS";
        AcademicYearMasterCS1: Record "Academic Year Master-CS";
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
        CurrentAcademicYear: Code[20];
        NextAcademicYear: Code[20];
        CurrentTerm: Option "FALL","SPRING";
        NextTerm: Option "FALL","SPRING";
        InstituteCode1: Code[20];
        SequenceNo: Integer;
        Text_10001Lbl: Label 'Do You Want To Generate Student Promotion Details ?';

    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF EducationSetup.FindFirst() then begin
            InstituteCode1 := EducationSetup."Global Dimension 1 Code";
            CurrentTerm := EducationSetup."Even/Odd Semester";
            IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::SPRING then begin
                NextTerm := NextTerm::FALL;
                CurrentAcademicYear := EducationSetup."Academic Year";
                NextAcademicYear := EducationSetup."Academic Year";
            end else begin
                NextTerm := NextTerm::SPRING;
                CurrentAcademicYear := EducationSetup."Academic Year";

                AcademicYearMasterCS1.Reset();
                AcademicYearMasterCS1.SetRange(Code, CurrentAcademicYear);
                IF AcademicYearMasterCS1.FindFirst() then
                    SequenceNo := AcademicYearMasterCS1.Sequence;

                IF SequenceNo <> 0 Then begin
                    AcademicYearMasterCS1.Reset();
                    AcademicYearMasterCS1.SetRange(Sequence, (SequenceNo + 1));
                    IF AcademicYearMasterCS1.FindFirst() then
                        NextAcademicYear := AcademicYearMasterCS1.Code;
                end;
            end;
        end;
    end;

}