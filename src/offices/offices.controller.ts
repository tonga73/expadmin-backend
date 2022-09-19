import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { OfficesService } from './offices.service';
import { CreateOfficeDto } from './dto/create-office.dto';
import { UpdateOfficeDto } from './dto/update-office.dto';

import { Office as OfficeModel } from '@prisma/client';

@Controller('offices')
export class OfficesController {
  constructor(private readonly officesService: OfficesService) {}

  // CREAR SECRETARIA
  @Post()
  create(@Body() createOfficeDto: CreateOfficeDto): Promise<OfficeModel> {
    return this.officesService.create(createOfficeDto);
  }

  // OBTENER TODAS LAS SECRETARIAS
  @Get()
  findAll(): Promise<OfficeModel[]> {
    return this.officesService.findAll({});
  }

  // OBTENER SECRETARIA POR ID
  @Get(':id')
  findOne(@Param('id') id: string): Promise<OfficeModel> {
    return this.officesService.findOne({ id: Number(id) });
  }

  // ACTUALIZAR SECRETARIA POR ID
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateOfficeDto: UpdateOfficeDto) {
    return this.officesService.update(+id, updateOfficeDto);
  }

  // ELIMINAR SECRETARIA POR ID
  @Delete(':id')
  remove(@Param('id') id: string): Promise<OfficeModel> {
    return this.officesService.remove({ id: Number(id) });
  }
}
