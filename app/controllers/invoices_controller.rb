class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update ]
  def index
    @invoices = Invoice.all
  end

  def show
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: 'Invoice was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:amount, :status)
  end
end
