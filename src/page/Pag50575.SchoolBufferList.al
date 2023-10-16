page 50575 "School Buffer List"
{

    PageType = List;
    // EntityName = 'sB';
    // EntitySetName = 'sB';
    DelayedInsert = true;
    Caption = 'School Buffer List';
    SourceTable = "School Buffer";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field("sLcMSchoolId"; Rec."SLcM School ID")
                {
                    ApplicationArea = All;
                }
                field(digitId; Rec."18 Digit ID")
                {
                    ApplicationArea = All;
                }
                field(namE; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("alternateEmailAddress"; Rec."Alternate Email Address")
                {
                    ApplicationArea = All;
                }
                field("accountPersonType"; Rec."Account Person Type")
                {
                    ApplicationArea = All;
                }
                field(advisoR; Rec.Advisor)
                {
                    ApplicationArea = All;
                }
                field("billingAddress"; Rec."Billing Address")
                {
                    ApplicationArea = All;
                }
                field("shippingAddress"; Rec."Shipping Address")
                {
                    ApplicationArea = All;
                }
                field("currentGPAScale"; Rec."Current GPA Scale")
                {
                    ApplicationArea = All;
                }
                field(phonE; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field(webSite; Rec.Website)
                {
                    ApplicationArea = All;
                }

                field("citY"; Rec."City")
                {
                    ApplicationArea = All;
                }
                field(statE; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(countrY; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field("zipCode"; Rec."Zip Code")
                {
                    ApplicationArea = All;
                }
                field(instituteCode; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    var
        RecSchool: Record "School";
        RecSchoolBuffer: Record "School Buffer";
        RecEducationSetup: Record "Education Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin


        RecSchoolBuffer.Reset();
        RecSchoolBuffer.SetRange("SLcM School ID", Rec."SLcM School ID");
        if RecSchoolBuffer.FindLast() then
            Rec."Line No." := RecSchoolBuffer."Line No." + 10000
        Else
            Rec."Line No." := 10000;

        RecEducationSetup.Reset();
        // RecEducationSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        if RecEducationSetup.FindFirst() then;

        IF Rec."SLcM School ID" <> '' then begin
            // Error('not equal');
            RecSchool.Reset();
            RecSchool.SetRange("School ID", Rec."SLcM School ID");
            IF RecSchool.FindFirst() then begin
                if RecSchool."18 Digit ID" <> Rec."18 Digit ID" then
                    Error('"18 Digit ID" %1 does not match with existing School No. %2', Rec."18 Digit ID", RecSchool."School ID");

                Recschool.Validate("18 Digit ID", Rec."18 Digit ID");
                RecSchool.Validate("Alternate Email Address", Rec."Alternate Email Address");
                RecSchool.Validate(Name, Rec.Name);
                RecSchool.Validate("Account Person Type", Rec."Account Person Type");
                RecSchool.Validate(Advisor, Rec.Advisor);
                RecSchool.Validate("Billing Address", Rec."Billing Address");
                RecSchool.Validate("Shipping Address", Rec."Shipping Address");
                RecSchool.Validate("Current GPA Scale", Rec."Current GPA Scale");
                RecSchool.Validate(Phone, Rec.Phone);
                RecSchool.Validate(Website, Rec.Website);
                RecSchool.Validate("City ", Rec.City);
                RecSchool.Validate(State, Rec.State);
                RecSchool.Validate(Country, Rec.Country);
                RecSchool.Validate("Zip Code", Rec."Zip Code");
                Rec.TestField("Global Dimension 1 Code");

                RecSchool.validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                Rec."Entry From Salesforce" := true;
                RecSchool."Entry From Salesforce" := true;
                RecSchool.Modify(True);
                Rec.Name := RecSchool.Name;
            end;
            // else begin
            //     RecSchool.Init();
            //     RecEducationSetup.Testfield("School ID");
            //     RecSchool.Validate("School ID", NoSeriesMgt.GetNextNo(RecEducationSetup."School ID", 0D, TRUE));
            //     Recschool.Validate("18 Digit ID", "18 Digit ID");
            //     RecSchool.Validate("Alternate Email Address", "Alternate Email Address");
            //     RecSchool.Validate(Name, Name);
            //     RecSchool.Validate("Account Person Type", "Account Person Type");
            //     RecSchool.Validate(Advisor, Advisor);
            //     RecSchool.Validate("Billing Address", "Billing Address");
            //     RecSchool.Validate("Shipping Address", "Shipping Address");
            //     RecSchool.Validate("Current GPA Scale", "Current GPA Scale");
            //     RecSchool.Validate(Phone, Phone);
            //     RecSchool.Validate(Website, Website);
            //     RecSchool.Validate("City ", City);
            //     RecSchool.Validate(State, State);
            //     RecSchool.Validate(Country, Country);
            //     RecSchool.Validate("Zip Code", "Zip Code");
            //     TestField("Global Dimension 1 Code");
            //     RecEducationSetup.Reset();
            //     RecEducationSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
            //     RecEducationSetup.FindFirst();
            //     RecSchool.validate("Global Dimension 1 Code", "Global Dimension 1 Code");
            //     "Entry From Salesforce" := true;
            //     RecSchool."Entry From Salesforce" := true;
            //     IF RecSchool.Insert(true) then begin
            //         "SLcM School ID" := RecSchool."School ID";
            //         RecSchoolBuffer.Reset();
            //         RecSchoolBuffer.SetRange("SLcM School ID", "SLcM School ID");
            //         if RecSchoolBuffer.FindLast() then begin
            //             "Line No." := RecSchoolBuffer."Line No." + 10000;
            //         end;
            //     end;
            //     Rec.Name := RecSchool.Name;
            // end;
        End;

        IF Rec."SLcM School ID" = '' then begin

            RecSchool.Reset();
            RecSchool.SetRange("18 Digit ID", Rec."18 Digit ID");
            IF not RecSchool.FindFirst() then begin

                RecSchool.Init();
                RecEducationSetup.Testfield("School ID");
                RecSchool.Validate("School ID", NoSeriesMgt.GetNextNo(RecEducationSetup."School ID", 0D, TRUE));

                Recschool.Validate("18 Digit ID", Rec."18 Digit ID");
                RecSchool.Validate("Alternate Email Address", Rec."Alternate Email Address");
                RecSchool.Validate(Name, Rec.Name);
                RecSchool.Validate("Account Person Type", Rec."Account Person Type");
                RecSchool.Validate(Advisor, Rec.Advisor);
                RecSchool.Validate("Billing Address", Rec."Billing Address");
                RecSchool.Validate("Shipping Address", Rec."Shipping Address");
                RecSchool.Validate("Current GPA Scale", Rec."Current GPA Scale");
                RecSchool.Validate(Phone, Rec.Phone);
                RecSchool.Validate(Website, Rec.Website);
                RecSchool.Validate("City ", Rec.City);
                RecSchool.Validate(State, Rec.State);
                RecSchool.Validate(Country, Rec.Country);
                RecSchool.Validate("Zip Code", Rec."Zip Code");
                Rec.TestField("Global Dimension 1 Code");
                RecEducationSetup.Reset();
                // RecEducationSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                RecEducationSetup.FindFirst();
                RecSchool.validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                Rec."Entry From Salesforce" := true;
                RecSchool."Entry From Salesforce" := true;

                RecSchool.Insert(true);// then begin

                Rec."SLcM School ID" := RecSchool."School ID";
                // Error('equal %1    %2', RecSchool."School ID", "SLcM School ID");
                RecSchoolBuffer.Reset();
                RecSchoolBuffer.SetRange("SLcM School ID", Rec."SLcM School ID");
                if RecSchoolBuffer.FindLast() then begin
                    Rec."Line No." := RecSchoolBuffer."Line No." + 10000;
                end;

                //End;
                Rec.Name := RecSchool.Name;
            end else begin
                Rec."SLcM School ID" := RecSchool."School ID";
                RecSchoolBuffer.Reset();
                RecSchoolBuffer.SetRange("SLcM School ID", Rec."SLcM School ID");
                if RecSchoolBuffer.FindLast() then begin
                    Rec."Line No." := RecSchoolBuffer."Line No." + 10000;
                end;
                Rec.Name := RecSchool.Name;
            end;
        end;
        RecSchool.Reset();
        RecSchool.SetRange("18 Digit ID", Rec."18 Digit ID");
        IF RecSchool.FindFirst() then begin
            Rec."18 Digit ID" := Recschool."18 Digit ID";
            Rec."Alternate Email Address" := RecSchool."Alternate Email Address";
            Rec.Name := RecSchool.Name;
            Rec."Account Person Type" := RecSchool."Account Person Type";
            Rec.Advisor := RecSchool.Advisor;
            Rec."Billing Address" := RecSchool."Billing Address";
            Rec."Shipping Address" := RecSchool."Shipping Address";
            Rec."Current GPA Scale" := RecSchool."Current GPA Scale";
            Rec.Phone := RecSchool.Phone;
            Rec.Website := RecSchool.Website;
            Rec.City := RecSchool."City ";
            Rec.State := RecSchool.State;
            Rec.Country := RecSchool.Country;
            Rec."Zip Code" := RecSchool."Zip Code";
        end;
    end;
}