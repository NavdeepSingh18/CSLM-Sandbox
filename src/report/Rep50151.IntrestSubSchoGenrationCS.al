report 50151 "Intrest Sub.Scho.Genration CS"
{
    // version V.001-CS

    ApplicationArea = All;
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Intrest Sub.Scho.Genration';

    dataset
    {
        dataitem("Customer"; "Customer")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                FeeCourseHeadCS.Reset();
                FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", Customer."Course Code");
                FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Fee Classification Code", Customer."Fee Classification Code");
                FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 2 Code", Customer."Global Dimension 2 Code");
                FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Academic Year", Customer."Academic Year");
                FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", Customer."Admitted Year");
                FeeCourseHeadCS.SETRANGE(Year, Customer.Year);
                IF FeeCourseHeadCS.findfirst() THEN BEGIN
                    ScholarshipHeaderCS.Reset();
                    ScholarshipHeaderCS.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                    ScholarshipHeaderCS.SETRANGE("Scholarship Code", 'INSUB');
                    ScholarshipHeaderCS.SETRANGE("Source Code", 'LOAN');
                    ScholarshipHeaderCS.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                    ScholarshipHeaderCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                    ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                    //ScholarshipHeaderCS.SETRANGE("Global Dimension 2 Code",Customer."Global Dimension 2 Code");
                    IF ScholarshipHeaderCS.findfirst() THEN BEGIN
                        ScholarshipLineCS.Reset();
                        ScholarshipLineCS.SETRANGE(ScholarshipLineCS."Document No.", ScholarshipHeaderCS."No.");
                        ScholarshipLineCS.SETRANGE("Scholarship Code", ScholarshipHeaderCS."Scholarship Code");
                        ScholarshipLineCS.SETFILTER("Min Parent Income", '<=%1', Customer."Parents Income");
                        ScholarshipLineCS.SETFILTER("Max Parent Income", '>=%1', Customer."Parents Income");
                        IF ScholarshipLineCS.findfirst() THEN BEGIN
                            IF (ScholarshipLineCS."Percentage To Pay" <> 0) OR ((Customer.Category = 'SFC') AND (Customer."Certification Course" = TRUE)) THEN BEGIN
                                FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                ParentAmount := (Customer."Parents Income" / 100) * ScholarshipLineCS."Percentage To Pay";
                                CourseAmount := (FeeCourseHeadCS."Total Amount" / 100) * ScholarshipLineCS."Percentage To Pay";
                                IF ParentAmount > CourseAmount THEN BEGIN
                                    DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") -
                                                  (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Percentage To Pay");
                                    IF DisAmount <> 0 THEN
                                        ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");

                                END ELSE
                                    IF CourseAmount > ParentAmount THEN BEGIN
                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") -
                                                      (Customer."Parents Income" / 100) * (ScholarshipLineCS."Percentage To Pay");
                                        IF DisAmount <> 0 THEN
                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                    END;

                            END ELSE
                                IF ScholarshipLineCS."Amount To Pay" <> 0 THEN BEGIN
                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                    DiscountAmount := FeeCourseHeadCS."Total Amount" - (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %");
                                    IF DiscountAmount > ScholarshipLineCS."Amount To Pay" THEN
                                        DisAmount := FeeCourseHeadCS."Total Amount" - DiscountAmount
                                    ELSE
                                        IF DiscountAmount < ScholarshipLineCS."Amount To Pay" THEN
                                            DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") - ScholarshipLineCS."Amount To Pay";
                                    IF DisAmount <> 0 THEN
                                        ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                END ELSE BEGIN
                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                    DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") - ScholarshipLineCS."Amount To Pay";
                                    IF DisAmount <> 0 THEN
                                        ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                END;


                            MESSAGE('%1', ScholarshipLineCS.Count());
                            MESSAGE('%1,%2,%3', ScholarshipLineCS."Discount %", Customer.Category, Customer."Parents Income");

                        END ELSE
                            ERROR(Text002Lbl);
                    END;
                END ELSE
                    ERROR(Text001Lbl);
            end;
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

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        ScholarshipHeaderCS: Record "Scholarship Header-CS";
        ScholarshipLineCS: Record "Scholarship Line-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        DisAmount: Decimal;
        ParentAmount: Decimal;
        CourseAmount: Decimal;
        DiscountAmount: Decimal;
        Text001Lbl: Label 'Course Fee Setup Not Exist !!';
        Text002Lbl: Label 'Please Upload Customer Parent Income !!  ';
}

