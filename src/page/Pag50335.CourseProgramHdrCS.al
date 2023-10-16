page 50335 "Course Program Hdr-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   14/02/2019       OnOpenPage()                Code added for open page college wise & field editable non editable.

    Caption = 'Course Program Hdr';
    PageType = Card;
    SourceTable = "Syllabus Course Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = ALl;
                    trigger OnAssistEdit()
                    begin
                        // Start 01.VIGNESH
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        // Stop 01.VIGNESH
                    end;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = ALl;

                    trigger OnValidate()
                    begin
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                    end;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = ALl;
                    trigger OnValidate()
                    begin
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = ALl;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = ALl;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = ALl;
                    Editable = EditableBTNSEM;
                }
                field(Year; Rec.Year)
                {
                    Caption = 'Year Code';
                    Editable = EditableBTNYR;
                    ApplicationArea = ALl;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = ALl;
                }
            }
            part("Course Program Line -CS";  50336)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."),
                              "Course Code" = FIELD("Course Code");
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //Code added for open page college wise & field editable non editable::CSPL-00059::14022019: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;


        EditableBTNSEM := FALSE;
        EditableBTNYR := FALSE;

        //Code added for open page college wise & field editable non editable::CSPL-00059::14022019: End
    end;

    var
        recUserSetup: Record "User Setup";
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;

}

