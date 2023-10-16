page 50058 "Fees Copy-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger                         Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  11-05-19   Header No - OnValidate()          Code added for Get value Academic Year and Admitted Year.
    // 02.   CSPL-00174  11-05-19   Header No - OnLookup()            Code added for page run and Get value Academic Year ,Admitted Year,Header no.
    // 03.   CSPL-00174  11-05-19   Copy Academic Year - OnLookup()   Code added for Page run and Get value of CopyAcademicYear.
    // 04.   CSPL-00174  11-05-19   Alloted Academic Year - OnLookup  Code added for Page run and Get value of AllotedAcademicYear.
    // 05.   CSPL-00174  11-05-19   Copy Admitted Year - OnLookup     Code added for Page run and Get value of CopyAdmittedYear.
    // 06.   CSPL-00174  11-05-19   Alloted Admitted Year - OnLookup  Code added for Page run and Get value of AllotedAdmittedYear.
    // 07.   CSPL-00174  11-05-19   Copyfees - OnAction()             Code added for Update Program Fee Details.
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Header No"; HeaderNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Header No';
                    Caption = 'Header No';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for page run and Get value Academic Year ,Admitted Year,Header no::CSPL-00174::110519: Start
                        FeeCourseHeadCS.RESET();
                        FeeCourseHeadCS.FINDSET();
                        IF PAGE.RUNMODAL(0, FeeCourseHeadCS) = ACTION::LookupOK THEN
                            HeaderNo := FeeCourseHeadCS."No.";

                        IF FeeCourseHeadCS.GET(HeaderNo) THEN BEGIN
                            CopyAcademicYear := FeeCourseHeadCS."Academic Year";
                            CopyAdmittedYear := FeeCourseHeadCS."Admitted Year";
                            CurrPage.Update();
                        END;
                        //Code added for page run and Get value Academic Year ,Admitted Year,Header no::CSPL-00174::110519: End
                    end;

                    trigger OnValidate()
                    begin
                        //Code added for Get value Academic Year and Admitted Year::CSPL-00174::110519: Start
                        IF FeeCourseHeadCS.GET(HeaderNo) THEN BEGIN
                            CopyAcademicYear := FeeCourseHeadCS."Academic Year";
                            CopyAdmittedYear := FeeCourseHeadCS."Admitted Year";
                            CurrPage.Update();
                        END;
                        // Code added for Get Academic Year and Admitted Year::CSPL-00174::110519: End
                    end;
                }
                field("Copy Academic Year"; CopyAcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Academic Year';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Page run and Get value of academic Year code::CSPL-00174::110519: Start
                        AcademicYearMasterCS.Reset();
                        AcademicYearMasterCS.FINDSET();
                        IF PAGE.RUNMODAL(0, AcademicYearMasterCS) = ACTION::LookupOK THEN
                            CopyAcademicYear := AcademicYearMasterCS.Code;
                        //Code added for Page run and Get value of Copy academic Year code::CSPL-00174::110519: End
                    end;
                }
                field("Alloted Academic Year"; AllotedAcademicYear)
                {
                    Caption = 'Alloted Academic Year';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Page run and Get value of Alloted Academic Year::CSPL-00174::110519: Start
                        AcademicYearMasterCS.Reset();
                        AcademicYearMasterCS.FINDSET();
                        IF PAGE.RUNMODAL(0, AcademicYearMasterCS) = ACTION::LookupOK THEN
                            AllotedAcademicYear := AcademicYearMasterCS.Code;
                        //Code added for Page run and Get value of Alloted Academic Year::CSPL-00174::110519: End
                    end;
                }
                field("Copy Admitted Year"; CopyAdmittedYear)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Admitted Year';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Page run and Get value of Copy Admitted Year::CSPL-00174::110519: Start
                        AcademicYearMasterCS.Reset();
                        AcademicYearMasterCS.FINDSET();
                        IF PAGE.RUNMODAL(0, AcademicYearMasterCS) = ACTION::LookupOK THEN
                            CopyAdmittedYear := AcademicYearMasterCS.Code;

                        //Code added for Page run and Get value of Copy Admitted Year::CSPL-00174::110519: End
                    end;
                }
                field("Alloted Admitted Year"; AllotedAdmittedYear)
                {
                    ApplicationArea = All;
                    Caption = 'Alloted Admitted Year';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Page run and Get value of AllotedAdmittedYear::CSPL-00174::110519: Start
                        AcademicYearMasterCS.Reset();
                        AcademicYearMasterCS.FINDSET();
                        IF PAGE.RUNMODAL(0, AcademicYearMasterCS) = ACTION::LookupOK THEN
                            AllotedAdmittedYear := AcademicYearMasterCS.Code;
                        //Code added for Page run and Get value of AllotedAdmittedYear::CSPL-00174::110519: End
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Copyfees)
            {
                Caption = 'Copy fees';
                Image = Calculate;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Update Program Fee Details::CSPL-00174::110519: Start
                    IF (CopyAcademicYear <> '') OR (AllotedAcademicYear <> '') OR (CopyAdmittedYear <> '') OR (AllotedAdmittedYear <> '') THEN BEGIN
                        IF CONFIRM(Text_10001Lbl, FALSE) THEN
                            AdmissionStage1CS.ProgramFeeDetailsCopyCS(HeaderNo, CopyAdmittedYear, CopyAcademicYear, AllotedAdmittedYear, AllotedAcademicYear)
                        ELSE
                            EXIT;
                    END ELSE
                        ERROR('Please Fill All Filter');
                    CurrPage.CLOSE();
                    MESSAGE('Fees Setup Created!!')
                    //Code added for Update Program Fee Details::CSPL-00174::110519: End
                end;
            }
        }
    }

    var


        FeeCourseHeadCS: Record "Fee Course Head-CS";
        AcademicYearMasterCS: Record "Academic Year Master-CS";
        AdmissionStage1CS: Codeunit "Admission Stage1-CS";

        HeaderNo: Code[20];
        CopyAcademicYear: Code[20];
        AllotedAcademicYear: Code[20];
        CopyAdmittedYear: Code[20];
        AllotedAdmittedYear: Code[20];
        Text_10001Lbl: Label 'Do You Want To fee Generate ?';
}

