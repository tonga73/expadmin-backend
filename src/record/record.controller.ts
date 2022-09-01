import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Patch,
  Delete,
} from '@nestjs/common';
import { RecordService } from './record.service';
import { Record as RecordModel } from '@prisma/client';

import { CreateRecordDto } from './dto/create-record.dto';
import { UpdateRecordDto } from './dto/update-record.dto';

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
    recordData: CreateRecordDto,
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

  // EDITAR EXPEDIENTE
  @Patch('record/:id')
  async editRecord(
    @Param('id') id: number,
    @Body() updateRecordDto: UpdateRecordDto,
  ): Promise<RecordModel> {
    return this.recordService.updateRecord(+id, updateRecordDto);
  }

  // ELIMINAR EXPEDIENTE
  @Delete('record/:id')
  async removeRecord(@Param('id') id: string): Promise<RecordModel> {
    return this.recordService.deleteRecord({ id: Number(id) });
  }
}
