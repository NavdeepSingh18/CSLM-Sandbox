page 50830 HousingRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueHousing;
    Caption = 'Housing Role Center';

    layout
    {
        area(Content)
        {
            cuegroup("Housing Statistics")
            {
                field("Total Housing"; Rec."Total Housing")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Master List";//"50413"
                }
                field("Total Room"; Rec."Total Room")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Room Master List";//"50417"
                }
                field("Total Bed"; Rec."Total Bed")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Room Wise Bed List";//"50419";
                    Caption = 'Total Room';
                }
                field("Total Available Room"; Rec."Total Available Room")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Room Master List";//"50417"//Changed
                    Caption = 'Total Available Apartment';
                }
                field("Total Available Bed"; Rec."Total Available Bed")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Room Wise Bed List";//"50419"//Changed
                    Caption = 'Total Available Room';
                }
            }
            cuegroup("Pending Applications")
            {
                field("Total Pending Housing Apps"; Rec."Total Pending Housing Apps")
                {
                    caption = 'Housing Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Application List";//"50421"
                }
                field("Total Png Housing Waiver Apps"; Rec."Total Png Housing Waiver Apps")
                {
                    Caption = 'Waiver Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pndg Housing Wavier List";//"50911"
                }
                field("Total Pendg Housing Issue Apps"; Rec."Total Pendg Housing Issue Apps")
                {
                    Caption = 'Issue Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Issue Pending List";// "50468"
                }
                field("Total Pndg Housing Change Apps"; Rec."Total Pndg Housing Change Apps")
                {
                    Caption = 'Change Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Change Request List";//"50423"
                }
                field("Total Pndg Housing Vacate Apps"; Rec."Total Pndg Housing Vacate Apps")
                {
                    Caption = 'Vacate Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Vacate Request List";//"50428"
                }
                field("Total Png Housing Re-Regi."; Rec."Total Png Housing Re-Regi.")
                {
                    Caption = 'Re-Registration Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Re-Registration List";//"50706"
                }
                field("Total png Fin. acc. Apps"; Rec."Total png Fin. acc. Apps")
                {
                    Caption = 'Financial Accountability Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Fin Account List";//"50711"
                }

                field("Total Png Parking Applications"; Rec."Total Png Parking Applications")
                {
                    Caption = 'Parking Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Parking Details List";//"50523"
                }
                field("Total Pending Immigration Apps"; Rec."Total Pending Immigration Apps")
                {
                    Caption = 'Immigration Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Immigration list";//"50693"
                }
                field("Housing Sign -off"; Rec."Housing Sign -off")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
            }
        }
    }
    trigger OnOpenPage();
    var
        UserSetup: Record "User Setup";
        EducationSetup: record "Education Setup-CS";
    begin
        Rec.RESET();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        UserSetup.Get(UserId());
        //Rec.Reset();
        Rec.setfilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
        if UserSetup."Global Dimension 1 Code" <> '' then
            if Strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                Rec.SetFilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
                EducationSetup.reset();
                EducationSetup.SetRange(EducationSetup."Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindFirst() then
                    Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
            end else begin
                EducationSetup.reset();
                if EducationSetup.FindFirst() then
                    Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
            end Else begin
            EducationSetup.reset();
            if EducationSetup.FindFirst() then
                Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year")
        end;

        if Rec.FindFirst() then;
    end;
}