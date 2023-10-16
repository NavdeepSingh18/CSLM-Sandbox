page 51079 StudSubjGrdBookSummaryFactbox
{
    PageType = CardPart;
    Caption = 'Grade Summary';
    // ApplicationArea = All;
    // UsageCategory = Lists;
    SourceTable = "Grade Master Grade Book";
    // SourceTableTemporary = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    // PageType = CardPart;
    layout
    {
        area(Content)
        {
            repeater(StudentDetails)
            {


                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    Caption = 'Grade';

                }
                field("Total Students"; Rec."Total Students")
                {
                    Caption = 'Total Students';
                    ApplicationArea = all;
                }


            }
        }
    }
    trigger OnOpenPage()
    var
        StudSubGB: Record "Student Subject GradeBook";
        // StudSubGBTemp: Record "Student Subject GradeBook" temporary;
        GradeMstrGB: Record "Grade Master Grade Book";
    // GradeMstrGBTemp: Record "Grade Master Grade Book" temporary;

    // DataInserted: Integer;
    begin
        // if GradeBookNo <> '' then begin
        // GradeMstrGB.Reset();
        // GradeMstrGB.SetRange("Grade Book No.", GradeBookNo);
        // if GradeMstrGB.FindSet() then
        //     repeat
        //         // GradeMstrGBTemp.Reset();
        //         // GradeMstrGBTemp.Init();
        //         // GradeMstrGBTemp.TransferFields(GradeMstrGB);
        //         // GradeMstrGBTemp.Insert();
        //         Rec.Reset();
        //         Rec.Init();
        //         Rec := GradeMstrGB;
        //         Rec.Insert();
        //     until GradeMstrGB.Next() = 0;
        /////////////////////
        // StudSubGB.Reset();
        // StudSubGB.SetRange("Grade Book No.", Rec."Grade Book No.");
        // if StudSubGB.FindSet() then
        //     repeat
        //         GradeMstrGB.Reset();
        //         GradeMstrGB.SetRange("Grade Book No.", Rec."Grade Book No.");
        //         GradeMstrGB.SetRange(Code, StudSubGB.Grade);
        //         if GradeMstrGB.FindFirst() then begin
        //             GradeMstrGB."Total Students" += 1;
        //             GradeMstrGB.Modify();
        //         end;
        //     until StudSubGB.Next() = 0;
        ////////////////
        // end;
    end;

    // procedure GetGradeBookNo(pGradeBookNo: Code[20])
    // begin
    //     GradeBookNo := pGradeBookNo;
    // end;

    var
        GradeBookNo: Code[20];


}