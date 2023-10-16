page 51001 "MSPE Factbox"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = MSPE;
    //CardPageId = "MSPE Application Card";

    layout
    {
        area(Content)
        {
            group(Information)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                    Editable = False;

                }

                Field("Student Name"; Rec."First Name" + ' ' + Rec."Last Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                field("Total Counts"; Rec."Application Count")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MSPE_gRec.Reset();
                        MSPE_gRec.FilterGroup(2);
                        MSPE_gRec.SetRange("Student No", Rec."Student No");
                        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
                        MSPE_gRec.FilterGroup(0);
                        Page.RunModal(Page::"MSPE Application List", MSPE_gRec);
                    end;

                }
                field("Pending Application"; Pending_gInt)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnDrillDown()
                    Begin
                        MSPE_gRec.Reset();
                        MSPE_gRec.FilterGroup(2);
                        MSPE_gRec.SetRange("Student No", Rec."Student No");
                        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
                        MSPE_gRec.SetFilter("Processing Status", '=%1|=%2', MSPE_gRec."Processing Status"::Pending, MSPE_gRec."Processing Status"::"In-Progress");
                        MSPE_gRec.FilterGroup(0);
                        Page.RunModal(Page::"Pending MSPE Application List", MSPE_gRec);
                    End;
                }
                Field("In-Review Application"; InReview_gInt)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = ShowColumn;
                    trigger OnDrillDown()
                    Begin
                        MSPE_gRec.Reset();
                        MSPE_gRec.FilterGroup(2);
                        MSPE_gRec.SetRange("Student No", Rec."Student No");
                        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
                        MSPE_gRec.SetRange("Processing Status", MSPE_gRec."Processing Status"::"In-Review");
                        MSPE_gRec.FilterGroup(0);
                        Page.RunModal(Page::"In-Review MSPE App List", MSPE_gRec);
                    End;
                }
                Field("Review Required Application"; ReviewRequired_gInt)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = ShowColumn;
                    trigger OnDrillDown()
                    Begin
                        MSPE_gRec.Reset();
                        MSPE_gRec.FilterGroup(2);
                        MSPE_gRec.SetRange("Student No", Rec."Student No");
                        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
                        MSPE_gRec.SetRange("Processing Status", MSPE_gRec."Processing Status"::"Review Required");
                        MSPE_gRec.FilterGroup(0);
                        Page.RunModal(Page::"Review Required MSPE App List", MSPE_gRec);
                    End;
                }
                field("Completed Application"; Completed_gInt)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnDrillDown()
                    Begin
                        MSPE_gRec.Reset();
                        MSPE_gRec.FilterGroup(2);
                        MSPE_gRec.SetRange("Student No", Rec."Student No");
                        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
                        MSPE_gRec.SetRange("Processing Status", MSPE_gRec."Processing Status"::Completed);
                        MSPE_gRec.FilterGroup(0);
                        Page.RunModal(Page::"Completed MSPE App List", MSPE_gRec);
                    End;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        ShowColumn := true;
        IF Rec."Application Type" = Rec."Application Type"::Repeated then
            ShowColumn := false;
    end;

    trigger OnAfterGetRecord()
    Begin
        Pending_gInt := 0;
        InReview_gInt := 0;
        ReviewRequired_gInt := 0;
        Completed_gInt := 0;

        MSPE_gRec.Reset();
        MSPE_gRec.SetRange("Student No", Rec."Student No");
        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
        MSPE_gRec.SetFilter("Processing Status", '=%1|=%2', MSPE_gRec."Processing Status"::Pending, MSPE_gRec."Processing Status"::"In-Progress");
        Pending_gInt := MSPE_gRec.Count();

        MSPE_gRec.Reset();
        MSPE_gRec.SetRange("Student No", Rec."Student No");
        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
        MSPE_gRec.SetRange("Processing Status", MSPE_gRec."Processing Status"::"In-Review");
        InReview_gInt := MSPE_gRec.Count();

        MSPE_gRec.Reset();
        MSPE_gRec.SetRange("Student No", Rec."Student No");
        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
        MSPE_gRec.SetRange("Processing Status", MSPE_gRec."Processing Status"::"Review Required");
        ReviewRequired_gInt := MSPE_gRec.Count();

        MSPE_gRec.Reset();
        MSPE_gRec.SetRange("Student No", Rec."Student No");
        MSPE_gRec.SetRange("Application Type", Rec."Application Type");
        MSPE_gRec.SetRange("Processing Status", MSPE_gRec."Processing Status"::Completed);
        Completed_gInt := MSPE_gRec.Count();

        ShowColumn := true;
        IF Rec."Application Type" = Rec."Application Type"::Repeated then
            ShowColumn := false;
    End;

    var
        MSPE_gRec: Record MSPE;
        Pending_gInt: Integer;
        InReview_gInt: Integer;
        ReviewRequired_gInt: Integer;
        Completed_gInt: Integer;
        ShowColumn: Boolean;
}