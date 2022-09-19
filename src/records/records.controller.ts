import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { RecordsService } from './records.service';
import { CreateRecordDto } from './dto/create-record.dto';
import { UpdateRecordDto } from './dto/update-record.dto';

import { Record as RecordModel } from '@prisma/client';

@Controller('records')
export class RecordsController {
  constructor(private readonly recordsService: RecordsService) {}

  // CREAR EXPEDIENTE
  @Post()
  async create(@Body() createRecordDto: CreateRecordDto): Promise<RecordModel> {
    return this.recordsService.create(createRecordDto);
  }

  // OBTENER TODOS LOS EXPEDIENTES
  @Get()
  findAll(): Promise<RecordModel[]> {
    return this.recordsService.findAll({});
  }

  // OBTENER EXPEDIENTE POR ID`
  @Get(':id')
  findOne(@Param('id') id: string): Promise<RecordModel> {
    return this.recordsService.findOne({ id: Number(id) });
  }

  // ACTUALIZAR EXPEDIENTE POR ID
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateRecordDto: UpdateRecordDto) {
    return this.recordsService.update(+id, updateRecordDto);
  }

  // ELIMINAR EXPEDIENTE POR ID
  @Delete(':id')
  remove(@Param('id') id: string): Promise<RecordModel> {
    return this.recordsService.remove({ id: Number(id) });
  }
}
