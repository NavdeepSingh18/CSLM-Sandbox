page 50260 "Time Templt Hdr-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                     Remarks
    // 1         CSPL-00092    11-05-2019    OnAfterGetRecord                            Check Restriction After Release.
    // 2         CSPL-00092    11-05-2019    OnNewRecord                                 Check Restriction After Release
    // 3         CSPL-00092    11-05-2019    Release - OnAction                          Release the document
    // 4         CSPL-00092    11-05-2019    Reopen - OnAction                           Open the document
    Caption = 'Time Slot Template Card';
    PageType = Document;
    SourceTable = "Time Table Template Head-CS";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = ReleaseDocument;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }


                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                Field("With Topic Code"; Rec."With Topic Code")
                {
                    ApplicationArea = All;
                }
            }
            part("Time Template SubPage"; 50261)
            {
                Editable = ReleaseDocument;
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Release)
            {
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedOnly = true;
                ShortCutKey = 'Ctrl+F9';
                ApplicationArea = All;
                PromotedCategory = Process;
                Enabled = ReleaseEnabled;
                trigger OnAction()
                var
                // ReleasePurchDoc: Codeunit "Release Purchase Document";
                begin
                    //Code added for Release the document::CSPL-00092::11-05-2019: Start
                    If not Confirm('Do you want to release %1 Template?', False, Rec."Template Name") then
                        exit;

                    TimeTableTemplateLineCS.Reset();
                    TimeTableTemplateLineCS.SETRANGE("Document No.", Rec."No.");
                    TimeTableTemplateLineCS.SETRANGE(Interval, FALSE);
                    IF TimeTableTemplateLineCS.FINDFIRST() THEN BEGIN
                        REPEAT
                            TimeTableTemplateLineCS.TESTFIELD("Time Slot");
                            TimeTableTemplateLineCS.TESTFIELD("Template Name");
                            TimeTableTemplateLineCS.TESTFIELD("Subject Class");
                            //TimeTableTemplateLineCS.TESTFIELD("Subject Group");
                            TimeTableTemplateLineCS.TESTFIELD(Day);
                        UNTIL TimeTableTemplateLineCS.NEXT() = 0;

                        IF Rec.Status = Rec.Status::Open THEN
                            Rec.Status := Rec.Status::Released;
                        Rec.Modify();
                        CurrPage.Update();
                    END;
                    //Code added for Release the document::CSPL-00092::11-05-2019: End
                end;
            }
            action(Reopen)
            {
                Caption = 'Re&open';
                Image = ReOpen;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Enabled = ReopenEnabled;
                trigger OnAction()
                var
                //  ReleasePurchDoc: Codeunit "Release Purchase Document";
                begin
                    //Code added for Open the document::CSPL-00092::11-05-2019: Start
                    // ClassTimeTableHeaderCS.Reset();
                    // ClassTimeTableHeaderCS.SETRANGE("Template Code", "No.");
                    // IF ClassTimeTableHeaderCS.FINDFIRST() THEN
                    //     ERROR('This Template No is already used in Time Table Header')
                    // ELSE
                    If not Confirm('Do you want to reopen %1 Template?', False, Rec."Template Name") then
                        exit;

                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    CurrPage.Update();
                    //Code added for Open the document::CSPL-00092::11-05-2019: End
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for Check Restriction After Release::CSPL-00092::11-05-2019: Start
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec.Status, ReleaseDocument);
        //Code added for Check Restriction After Release::CSPL-00092::11-05-2019: End

        ReopenEnabled := false;
        IF Rec.Status = Rec.Status::Released then
            ReopenEnabled := true;


        ReleaseEnabled := false;
        IF Rec.Status = Rec.Status::Open then
            ReleaseEnabled := true;

    end;

    trigger OnOpenPage()
    begin
        ReopenEnabled := false;
        IF Rec.Status = Rec.Status::Released then
            ReopenEnabled := true;


        ReleaseEnabled := false;
        IF Rec.Status = Rec.Status::Open then
            ReleaseEnabled := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added for Check Restriction After Release::CSPL-00092::11-05-2019: Start
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec.Status, ReleaseDocument);
        //Code added for Check Restriction After Release::CSPL-00092::11-05-2019: End
    end;

    var
        TimeTableTemplateLineCS: Record "Time Table Template Line-CS";
        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        ReleaseDocument: Boolean;
        ReleaseEnabled: Boolean;
        ReopenEnabled: Boolean;

}