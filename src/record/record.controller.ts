import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { RecordService } from './record.service';
import { Record as RecordModel } from '@prisma/client';

@Controller()
export class RecordController {
  constructor(private readonly recordService: RecordService) {}

  // OBTENER TODOS LOS EXPEDIENTES
  @Get('records')
  async getRecords(): Promise<RecordModel[]> {
    return this.recordService.records({});
  }

  // OBTENER EL EXPEDIENTE COMPLETO
  @Get('record/:id')
  async getRecordById(@Param('id') id: string): Promise<RecordModel> {
    return this.recordService.record({ id: Number(id) });
  }

  // CREAR EXPEDIENTE
  @Post('record')
  async newRecord(
    @Body()
    recordData: {
      title: string;
      order?: string;
      archive?: boolean;
      status?: string;
      priority?: string;
    },
  ): Promise<RecordModel> {
    const { title, order, archive, status, priority } = recordData;
    return this.recordService.createRecord({
      title,
      order,
      archive,
      status,
      priority,
    });
  }
}
